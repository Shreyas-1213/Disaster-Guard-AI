package com.disaster.test;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.disaster.intelligence.DisasterRiskService;
import com.disaster.intelligence.FourDayRiskService;
import com.disaster.intelligence.RiskTrendService;
import com.disaster.intelligence.RoadSafetyService;

import com.disaster.weather.Forecast72HourParser;
import com.disaster.weather.Forecast72HourService;
import com.disaster.weather.ForecastData;
import com.disaster.weather.FourDayForecastService;

public class RealFourDayRiskTest {

    public static void main(String[] args) {

        String latitude = "13.0147";
        String longitude = "77.5648";

        // =========================================
        // 1. GET REAL OPENWEATHER FORECAST
        // =========================================

        Forecast72HourService forecastService =
                new Forecast72HourService();

        String json =
                forecastService.get72HourForecast(
                        latitude,
                        longitude
                );

        // =========================================
        // 2. PARSE FORECAST
        // =========================================

        Forecast72HourParser parser =
                new Forecast72HourParser();

        List<ForecastData> forecasts =
                parser.parse72Hours(json);

        // =========================================
        // 3. GROUP FORECAST INTO DAYS
        // =========================================

        FourDayForecastService dayService =
                new FourDayForecastService();

        Map<LocalDate, List<ForecastData>> fourDays =
                dayService.groupIntoFourDays(
                        forecasts
                );

        // =========================================
        // 4. CREATE RISK SERVICES
        // =========================================

        DisasterRiskService disasterService =
                new DisasterRiskService();

        RoadSafetyService roadService =
                new RoadSafetyService();

        FourDayRiskService riskService =
                new FourDayRiskService();

        // Store real daily risk scores here
        List<Integer> dailyScores =
                new ArrayList<>();

        System.out.println(
                "========== 4 DAY PERSONAL RISK FORECAST =========="
        );

        int dayNumber = 1;

        // =========================================
        // 5. ANALYZE EACH DAY
        // =========================================

        for (Map.Entry<LocalDate, List<ForecastData>> entry
                : fourDays.entrySet()) {

            String result =
                    riskService.analyzeDay(
                            entry.getValue(),
                            disasterService,
                            roadService
                    );

            String[] parts =
                    result.split("\\|", 8);

            if (parts.length < 8) {

                System.out.println(
                        "Unexpected result format: "
                        + result
                );

                continue;
            }

            // =====================================
            // SAVE DAILY RISK SCORE
            // =====================================

            int score;

            try {

                score =
                        Integer.parseInt(
                                parts[1]
                        );

            } catch (NumberFormatException e) {

                score = 0;
            }

            dailyScores.add(score);

            // =====================================
            // DISPLAY DAY RESULT
            // =====================================

            System.out.println();

            System.out.println(
                    "================================"
            );

            System.out.println(
                    "DAY "
                    + dayNumber
                    + " - "
                    + entry.getKey()
            );

            System.out.println(
                    "================================"
            );

            System.out.println(
                    "Overall Risk : "
                    + parts[0]
            );

            System.out.println(
                    "Risk Score : "
                    + parts[1]
            );

            System.out.println(
                    "Road Safety : "
                    + parts[2]
            );

            System.out.println(
                    "Total Rainfall : "
                    + parts[3]
                    + " mm"
            );

            System.out.println(
                    "Maximum Wind : "
                    + parts[4]
                    + " m/s"
            );

            System.out.println(
                    "Maximum Temperature : "
                    + parts[5]
                    + " °C"
            );

            System.out.println(
                    "Minimum Visibility : "
                    + parts[6]
                    + " km"
            );

            System.out.println(
                    "Reason : "
                    + parts[7]
            );

            dayNumber++;
        }

        // =========================================
        // 6. ANALYZE COMPLETE 4-DAY RISK TREND
        // =========================================

        if (!dailyScores.isEmpty()) {

            RiskTrendService trendService =
                    new RiskTrendService();

            String trendResult =
                    trendService.analyzeTrend(
                            dailyScores
                    );

            String[] trendParts =
                    trendResult.split("\\|", 5);

            // =====================================
            // 7. DISPLAY OVERALL SUMMARY
            // =====================================

            System.out.println();

            System.out.println(
                    "=============================================="
            );

            System.out.println(
                    "       OVERALL 4-DAY RISK SUMMARY"
            );

            System.out.println(
                    "=============================================="
            );

            if (trendParts.length >= 5) {

                System.out.println(
                        "Risk Trend : "
                        + trendParts[0]
                );

                System.out.println(
                        "Highest Risk : "
                        + trendParts[1]
                );

                System.out.println(
                        "Highest Score : "
                        + trendParts[2]
                );

                System.out.println(
                        "Highest Risk Day : Day "
                        + trendParts[3]
                );

                System.out.println(
                        "Recommendation : "
                        + trendParts[4]
                );

            } else {

                System.out.println(
                        "Unable to calculate risk trend."
                );
            }

        } else {

            System.out.println(
                    "No daily risk scores available."
            );
        }
    }
}