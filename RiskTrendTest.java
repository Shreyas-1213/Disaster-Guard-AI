package com.disaster.test;

import java.util.Arrays;
import java.util.List;

import com.disaster.intelligence.RiskTrendService;

public class RiskTrendTest {

    public static void main(String[] args) {

        List<Integer> scores =
                Arrays.asList(
                        0,
                        20,
                        45,
                        30
                );

        RiskTrendService service =
                new RiskTrendService();

        String result =
                service.analyzeTrend(scores);

        String[] parts =
                result.split("\\|", 5);

        System.out.println(
                "Risk Trend : "
                + parts[0]
        );

        System.out.println(
                "Highest Risk : "
                + parts[1]
        );

        System.out.println(
                "Highest Score : "
                + parts[2]
        );

        System.out.println(
                "Highest Risk Day : Day "
                + parts[3]
        );

        System.out.println(
                "Recommendation : "
                + parts[4]
        );
    }
}