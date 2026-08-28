package com.disaster.test;

import com.disaster.intelligence.AutomaticDangerService;
import com.disaster.intelligence.DisasterRiskService;
import com.disaster.intelligence.RoadSafetyService;

public class IntelligenceTest {

    public static void main(String[] args) {

        DisasterRiskService disasterService =
                new DisasterRiskService();

        RoadSafetyService roadService =
                new RoadSafetyService();

        AutomaticDangerService dangerService =
                new AutomaticDangerService();


        String disasterResult =
                disasterService.calculateRisk(
                        42,
                        92,
                        60,
                        18
                );


        String roadResult =
                roadService.checkDrivingSafety(
                        60,
                        18,
                        1.5
                );


        System.out.println(
                "Disaster Result: "
                + disasterResult
        );

        System.out.println(
                "Road Result: "
                + roadResult
        );


        String disasterLevel =
                disasterResult.split("\\|")[0];

        String roadLevel =
                roadResult.split("\\|")[0];


        boolean danger =
                dangerService.isDangerous(
                        disasterLevel,
                        roadLevel
                );


        System.out.println(
                "Automatic Danger: "
                + danger
        );
    }
}