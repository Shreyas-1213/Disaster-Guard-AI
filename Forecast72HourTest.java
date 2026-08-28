package com.disaster.test;

import com.disaster.weather.Forecast72HourService;

public class Forecast72HourTest {

    public static void main(String[] args) {

        Forecast72HourService service =
                new Forecast72HourService();

        String result =
                service.get72HourForecast(
                        "13.0147",
                        "77.5648"
                );

        System.out.println(result);
    }
}