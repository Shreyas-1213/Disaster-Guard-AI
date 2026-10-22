
package com.disaster.intelligence;
import java.net.http.HttpTimeoutException;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

public class GeminiService {

    private static final String API_URL =
        "https://generativelanguage.googleapis.com/v1beta/models/"
        + "gemini-3.5-flash:generateContent";

    private static final int MAX_ATTEMPTS = 3;

    private final HttpClient client = HttpClient.newBuilder()
        .connectTimeout(Duration.ofSeconds(20))
        .build();

    public String getResponse(String question)
            throws IOException, InterruptedException {

        String apiKey = System.getenv("GEMINI_API_KEY");

        if (apiKey == null || apiKey.isBlank()) {
            throw new IllegalStateException(
                "GEMINI_API_KEY environment variable is not configured."
            );
        }

        if (question == null || question.isBlank()) {
            return "Please enter a question.";
        }

        String prompt =
            "You are DisasterGuard AI, a disaster safety assistant. "
            + "Give clear, practical, concise safety guidance. "
            + "Never invent live alerts or claim to know a user's local "
            + "conditions without verified data. Encourage users to follow "
            + "official emergency instructions. For immediate danger, "
            + "tell them to contact local emergency services. "
            + "If a question is unrelated to disaster safety, politely "
            + "explain your specialty.\n\nUser question: "
            + question.trim();

        String requestBody =
            "{\"contents\":[{\"parts\":[{\"text\":\""
            + escapeJson(prompt)
            + "\"}]}]}";

        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(API_URL))
            .timeout(Duration.ofSeconds(60))
            .header("Content-Type", "application/json")
            .header("x-goog-api-key", apiKey)
            .POST(HttpRequest.BodyPublishers.ofString(requestBody))
            .build();

        HttpResponse<String> response = null;

        for (int attempt = 1; attempt <= MAX_ATTEMPTS; attempt++) {

            System.out.println(
                "Sending Gemini API request. Attempt "
                + attempt + " of " + MAX_ATTEMPTS
            );

            try {
                response = client.send(
                    request,
                    HttpResponse.BodyHandlers.ofString()
                );

            } catch (HttpTimeoutException e) {

                System.err.println(
                    "Gemini request timed out on attempt " + attempt
                );

                if (attempt == MAX_ATTEMPTS) {
                    throw e;
                }

                Thread.sleep(attempt * 2000L);
                continue;
            }

            if (response.statusCode() == 200) {
                return extractResponseText(response.body());
            }

            int statusCode = response.statusCode();

            System.err.println(
                "Gemini API returned HTTP " + statusCode
            );

            System.err.println(
                "Gemini error details: " + response.body()
            );

            // Retry only temporary service-unavailable errors.
            if (statusCode != 503 || attempt == MAX_ATTEMPTS) {
                throw new IOException(
                    "Gemini could not generate a response. HTTP "
                    + statusCode
                );
            }

            long waitMillis = attempt * 2000L;

            System.out.println(
                "Gemini is temporarily unavailable. Retrying in "
                + (waitMillis / 1000) + " seconds..."
            );

            Thread.sleep(waitMillis);
        }

        throw new IOException(
            "Gemini could not generate a response after retries."
        );
    }

    private String escapeJson(String text) {
        return text.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }

    private String extractResponseText(String json)
            throws IOException {

        String marker = "\"text\":";
        int markerIndex = json.indexOf(marker);

        if (markerIndex == -1) {
            throw new IOException(
                "Gemini returned no text response."
            );
        }

        int start = json.indexOf('"', markerIndex + marker.length());

        if (start == -1) {
            throw new IOException(
                "Invalid Gemini response."
            );
        }

        StringBuilder result = new StringBuilder();
        boolean escaped = false;

        for (int i = start + 1; i < json.length(); i++) {
            char c = json.charAt(i);

            if (escaped) {
                switch (c) {
                    case 'n':
                        result.append('\n');
                        break;
                    case 'r':
                        result.append('\r');
                        break;
                    case 't':
                        result.append('\t');
                        break;
                    case '"':
                        result.append('"');
                        break;
                    case '\\':
                        result.append('\\');
                        break;
                    case 'b':
                        result.append('\b');
                        break;
                    case 'f':
                        result.append('\f');
                        break;
                    case 'u':
                        if (i + 4 < json.length()) {
                            try {
                                result.append((char) Integer.parseInt(
                                    json.substring(i + 1, i + 5), 16
                                ));
                                i += 4;
                            } catch (NumberFormatException e) {
                                throw new IOException(
                                    "Invalid Unicode in Gemini response."
                                );
                            }
                        } else {
                            throw new IOException(
                                "Incomplete Unicode escape in response."
                            );
                        }
                        break;
                    default:
                        result.append(c);
                        break;
                }

                escaped = false;

            } else if (c == '\\') {
                escaped = true;

            } else if (c == '"') {
                return result.toString();

            } else {
                result.append(c);
            }
        }

        throw new IOException(
            "Incomplete Gemini response."
        );
    }
}
