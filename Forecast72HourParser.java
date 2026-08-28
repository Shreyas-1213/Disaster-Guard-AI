package com.disaster.weather;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

public class Forecast72HourParser {

    public List<ForecastData> parse72Hours(String json) {

        List<ForecastData> forecasts = new ArrayList<>();

        if (json == null || json.isBlank()) {
            System.out.println("Forecast JSON is empty.");
            return forecasts;
        }

        try {

            JSONObject root = new JSONObject(json);

            if (!root.has("list")) {
                System.out.println(
                        "Forecast response does not contain list."
                );

                System.out.println(json);

                return forecasts;
            }

            JSONArray list =
                    root.getJSONArray("list");

            /*
             * OpenWeather forecast gives approximately
             * one forecast every 3 hours.
             *
             * 24 records = approximately 72 hours.
             */
            int limit = Math.min(24, list.length());

            for (int i = 0; i < limit; i++) {

                JSONObject item =
                        list.getJSONObject(i);

                JSONObject main =
                        item.getJSONObject("main");

                JSONObject wind =
                        item.getJSONObject("wind");

                String dateTime =
                        item.getString("dt_txt");

                double temperature =
                        main.getDouble("temp");

                double humidity =
                        main.getDouble("humidity");

                double windSpeed =
                        wind.getDouble("speed");

                double visibilityMeters =
                        item.optDouble(
                                "visibility",
                                10000
                        );

                double visibilityKm =
                        visibilityMeters / 1000.0;

                double rainfall = 0.0;

                if (item.has("rain")) {

                    JSONObject rain =
                            item.getJSONObject("rain");

                    rainfall =
                            rain.optDouble(
                                    "3h",
                                    0.0
                            );
                }

                ForecastData forecast =
                        new ForecastData(
                                dateTime,
                                temperature,
                                humidity,
                                rainfall,
                                windSpeed,
                                visibilityKm
                        );

                forecasts.add(forecast);
            }

            System.out.println(
                    "Forecast records parsed: "
                    + forecasts.size()
            );

        } catch (Exception e) {

            System.out.println(
                    "Error parsing forecast: "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return forecasts;
    }
}