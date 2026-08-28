package com.disaster.weather;

import org.json.JSONObject;

public class OpenWeatherParser {

    public WeatherData parseCurrentWeather(String json) {

        JSONObject root =
                new JSONObject(json);

        JSONObject main =
                root.getJSONObject("main");

        JSONObject wind =
                root.getJSONObject("wind");

        double temperature =
                main.getDouble("temp");

        double humidity =
                main.getDouble("humidity");

        double windSpeed =
                wind.getDouble("speed");

        double visibilityMeters =
                root.optDouble(
                        "visibility",
                        10000
                );

        double visibilityKm =
                visibilityMeters / 1000.0;

        double rainfall = 0.0;

        if (root.has("rain")) {

            JSONObject rain =
                    root.getJSONObject("rain");

            if (rain.has("1h")) {

                rainfall =
                        rain.getDouble("1h");

            } else if (rain.has("3h")) {

                rainfall =
                        rain.getDouble("3h");
            }
        }

        return new WeatherData(
                temperature,
                humidity,
                rainfall,
                windSpeed,
                visibilityKm
        );
    }
}