package com.disaster.weather;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class ForecastService {

    private static final String API_KEY =
            System.getenv("OPENWEATHER_API_KEY");

    public String getForecast(
            String latitude,
            String longitude) {

        StringBuilder response =
                new StringBuilder();

        try {

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

            BufferedReader reader =
                    new BufferedReader(
                            new InputStreamReader(
                                    connection.getInputStream()
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