package com.disaster.weather;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class Forecast72HourService {

    private static final String API_KEY =
            System.getenv("OPENWEATHER_API_KEY");

    public String get72HourForecast(
            String latitude,
            String longitude) {

        StringBuilder response =
                new StringBuilder();

        try {

            System.out.println(
                    "FORECAST API KEY available: "
                    + (API_KEY != null)
            );

            String apiUrl =
                    "https://api.openweathermap.org/data/2.5/forecast"
                    + "?lat=" + latitude
                    + "&lon=" + longitude
                    + "&units=metric"
                    + "&appid=" + API_KEY;

            URL url =
                    new URL(apiUrl);

            HttpURLConnection connection =
                    (HttpURLConnection)
                    url.openConnection();

            connection.setRequestMethod("GET");

            connection.setConnectTimeout(10000);
            connection.setReadTimeout(15000);

            int responseCode =
                    connection.getResponseCode();

            System.out.println(
                    "72 Hour Forecast Response Code: "
                    + responseCode
            );

            BufferedReader reader =
                    new BufferedReader(
                            new InputStreamReader(
                                    responseCode >= 200
                                    && responseCode < 300
                                    ? connection.getInputStream()
                                    : connection.getErrorStream()
                            )
                    );

            String line;

            while ((line = reader.readLine()) != null) {
                response.append(line);
            }

            reader.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return response.toString();
    }
}