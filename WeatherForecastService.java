package com.disaster.weather;

public class WeatherForecastService {

    public WeatherData getCurrentWeather(
            String latitude,
            String longitude) {

        System.out.println(
                "Weather requested for:"
        );

        System.out.println(
                "Latitude: " + latitude
        );

        System.out.println(
                "Longitude: " + longitude
        );

        /*
         * Temporary sample values.
         * Next we will replace these with
         * real automatic weather data.
         */

        return new WeatherData(
                32.0,
                80.0,
                10.0,
                5.0,
                8.0
        );
    }
}