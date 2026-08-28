package com.disaster.intelligence;

import java.util.List;

import com.disaster.weather.ForecastData;

public class FourDayRiskService {

    public String analyzeDay(
            List<ForecastData> dayForecasts,
            DisasterRiskService disasterService,
            RoadSafetyService roadService) {

        int highestRiskScore = 0;

        String highestRiskLevel = "LOW";
        String roadSafety = "SAFE TO DRIVE";

        double totalRain = 0.0;
        double maxWind = 0.0;
        double maxTemperature = 0.0;
        double minVisibility = 100.0;

        StringBuilder reasons =
                new StringBuilder();

        for (ForecastData data : dayForecasts) {

            totalRain += data.getRainfall();

            if (data.getWindSpeed() > maxWind) {
                maxWind = data.getWindSpeed();
            }

            if (data.getTemperature() > maxTemperature) {
                maxTemperature = data.getTemperature();
            }

            if (data.getVisibilityKm() < minVisibility) {
                minVisibility = data.getVisibilityKm();
            }

            String disasterResult =
                    disasterService.calculateRisk(
                            data.getTemperature(),
                            data.getHumidity(),
                            data.getRainfall(),
                            data.getWindSpeed()
                    );

            String[] disasterParts =
                    disasterResult.split("\\|", 3);

            String level =
                    disasterParts[0];

            int score = 0;

            try {
                score =
                        Integer.parseInt(
                                disasterParts[1]
                        );
            } catch (Exception e) {
                score = 0;
            }

            if (score > highestRiskScore) {

                highestRiskScore = score;
                highestRiskLevel = level;
            }

            String roadResult =
                    roadService.checkDrivingSafety(
                            data.getRainfall(),
                            data.getWindSpeed(),
                            data.getVisibilityKm()
                    );

            String currentRoad =
                    roadResult.split("\\|")[0];

            if ("UNSAFE TO DRIVE".equalsIgnoreCase(
                    currentRoad)) {

                roadSafety =
                        "AVOID TRAVEL";

            } else if (
                    "DRIVE WITH CAUTION".equalsIgnoreCase(
                            currentRoad)
                    &&
                    !"AVOID TRAVEL".equalsIgnoreCase(
                            roadSafety)) {

                roadSafety =
                        "DRIVE WITH CAUTION";
            }
        }


        // =============================
        // DAILY ACCUMULATED RAIN
        // =============================

        if (totalRain >= 50) {

            reasons.append(
                    "High accumulated rainfall. "
            );

            if (highestRiskScore < 60) {
                highestRiskScore = 60;
                highestRiskLevel = "HIGH";
            }

        } else if (totalRain >= 20) {

            reasons.append(
                    "Moderate accumulated rainfall. "
            );

            if (highestRiskScore < 30) {
                highestRiskScore = 30;
                highestRiskLevel = "MEDIUM";
            }
        }


        // =============================
        // WIND
        // =============================

        if (maxWind >= 15) {

            reasons.append(
                    "Strong winds expected. "
            );
        }


        // =============================
        // HEAT
        // =============================

        if (maxTemperature >= 40) {

            reasons.append(
                    "Extreme heat conditions possible. "
            );
        }


        // =============================
        // VISIBILITY
        // =============================

        if (minVisibility < 2) {

            reasons.append(
                    "Very poor visibility expected. "
            );

            roadSafety =
                    "AVOID TRAVEL";

        } else if (minVisibility < 5) {

            reasons.append(
                    "Reduced visibility expected. "
            );

            if (!"AVOID TRAVEL".equals(
                    roadSafety)) {

                roadSafety =
                        "DRIVE WITH CAUTION";
            }
        }


        if (reasons.length() == 0) {

            reasons.append(
                    "No major hazardous weather indicators detected."
            );
        }


        return highestRiskLevel
                + "|"
                + highestRiskScore
                + "|"
                + roadSafety
                + "|"
                + totalRain
                + "|"
                + maxWind
                + "|"
                + maxTemperature
                + "|"
                + minVisibility
                + "|"
                + reasons;
    }
}