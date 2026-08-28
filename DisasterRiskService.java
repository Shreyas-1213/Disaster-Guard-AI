package com.disaster.intelligence;

public class DisasterRiskService {

    public String calculateRisk(
            double temperature,
            double humidity,
            double rainfall,
            double windSpeed) {

        int score = 0;

        StringBuilder reasons =
                new StringBuilder();

        if (rainfall >= 50) {

            score += 40;

            reasons.append(
                    "Heavy rainfall detected. "
            );
        }
        else if (rainfall >= 25) {

            score += 20;

            reasons.append(
                    "Moderate rainfall detected. "
            );
        }

        if (humidity >= 90) {

            score += 15;

            reasons.append(
                    "Very high humidity. "
            );
        }

        if (temperature >= 40) {

            score += 25;

            reasons.append(
                    "Extreme temperature detected. "
            );
        }

        if (windSpeed >= 15) {

            score += 30;

            reasons.append(
                    "Strong wind detected. "
            );
        }

        String level;

        if (score >= 70) {

            level = "CRITICAL";

        } else if (score >= 45) {

            level = "HIGH";

        } else if (score >= 20) {

            level = "MEDIUM";

        } else {

            level = "LOW";
        }

        return level
                + "|"
                + score
                + "|"
                + reasons;
    }
}