package com.disaster.test;

import java.util.ArrayList;
import java.util.List;

import com.disaster.intelligence.DisasterRiskService;
import com.disaster.intelligence.FourDayRiskService;
import com.disaster.intelligence.RoadSafetyService;
import com.disaster.weather.ForecastData;

public class FourDayRiskTest {

    public static void main(String[] args) {

        List<ForecastData> sampleDay =
                new ArrayList<>();

        sampleDay.add(
                new ForecastData(
                        "2026-08-27 09:00:00",
                        30,
                        75,
                        5,
                        6,
                        10
                )
        );

        sampleDay.add(
                new ForecastData(
                        "2026-08-27 12:00:00",
                        31,
                        80,
                        8,
                        7,
                        8
                )
        );

        sampleDay.add(
                new ForecastData(
                        "2026-08-27 15:00:00",
                        27,
                        88,
                        15,
                        10,
                        4
                )
        );


        DisasterRiskService disasterService =
                new DisasterRiskService();

        RoadSafetyService roadService =
                new RoadSafetyService();

        FourDayRiskService fourDayService =
                new FourDayRiskService();


        String result =
                fourDayService.analyzeDay(
                        sampleDay,
                        disasterService,
                        roadService
                );


        System.out.println(
                "DAY RESULT:"
        );

        System.out.println(
                result
        );
    }
}