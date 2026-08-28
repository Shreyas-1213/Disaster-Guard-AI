package com.disaster.test;

import com.disaster.weather.OpenWeatherService;

public class OpenWeatherTest {

    public static void main(String[] args) {

        OpenWeatherService service =
                new OpenWeatherService();

        String result =
                service.getCurrentWeather(
                        "13.0085",
                        "77.5554"
                );

        System.out.println(result);
    }
}