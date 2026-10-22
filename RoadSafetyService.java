package com.disaster.intelligence;

public class RoadSafetyService {

    // =====================================================
    // EXISTING METHOD
    // Used by your current modules such as 4-day forecast
    // DO NOT REMOVE
    // =====================================================

    public String checkDrivingSafety(
            double rainfall,
            double windSpeed,
            double visibilityKm) {

        int score = 0;

        StringBuilder reasons =
                new StringBuilder();

        if (rainfall >= 50) {

            score += 40;

            reasons.append(
                    "Heavy rainfall may cause waterlogging. "
            );
        }

        if (windSpeed >= 15) {

            score += 30;

            reasons.append(
                    "Strong winds may affect vehicle stability. "
            );
        }

        if (visibilityKm < 2) {

            score += 40;

            reasons.append(
                    "Very poor visibility. "
            );

        } else if (visibilityKm < 5) {

            score += 20;

            reasons.append(
                    "Reduced visibility. "
            );
        }

        String result;

        if (score >= 70) {

            result = "UNSAFE TO DRIVE";

        } else if (score >= 30) {

            result = "DRIVE WITH CAUTION";

        } else {

            result = "SAFE TO DRIVE";
        }

        return result
                + "|"
                + reasons;
    }


    // =====================================================
    // NEW METHOD
    // Used for map-based road safety
    // Includes temperature
    // =====================================================

    public String checkDrivingSafety(
            double rainfall,
            double windSpeed,
            double visibilityKm,
            double temperature) {

        int score = 0;

        StringBuilder reasons =
                new StringBuilder();


        // =================================================
        // RAINFALL ANALYSIS
        // =================================================

        if (rainfall >= 50) {

            score += 40;

            reasons.append(
                    "Heavy rainfall may cause waterlogging and dangerous road conditions. "
            );

        } else if (rainfall >= 25) {

            score += 20;

            reasons.append(
                    "Moderate rainfall may make roads slippery. "
            );

        } else if (rainfall >= 10) {

            score += 10;

            reasons.append(
                    "Light to moderate rainfall may reduce road grip. "
            );
        }


        // =================================================
        // WIND ANALYSIS
        // =================================================

        if (windSpeed >= 20) {

            score += 40;

            reasons.append(
                    "Very strong winds may seriously affect vehicle stability. "
            );

        } else if (windSpeed >= 15) {

            score += 30;

            reasons.append(
                    "Strong winds may affect vehicle stability. "
            );

        } else if (windSpeed >= 10) {

            score += 15;

            reasons.append(
                    "Moderate winds may affect high-profile vehicles. "
            );
        }


        // =================================================
        // VISIBILITY ANALYSIS
        // =================================================

        if (visibilityKm < 1) {

            score += 50;

            reasons.append(
                    "Extremely poor visibility creates dangerous driving conditions. "
            );

        } else if (visibilityKm < 2) {

            score += 40;

            reasons.append(
                    "Very poor visibility requires avoiding unnecessary travel. "
            );

        } else if (visibilityKm < 5) {

            score += 20;

            reasons.append(
                    "Reduced visibility requires cautious driving. "
            );
        }


        // =================================================
        // TEMPERATURE ANALYSIS
        // =================================================

        if (temperature >= 45) {

            score += 40;

            reasons.append(
                    "Extreme heat may cause driver fatigue, tyre stress and vehicle overheating. "
            );

        } else if (temperature >= 40) {

            score += 30;

            reasons.append(
                    "Very high temperature may increase driver fatigue and vehicle stress. "
            );

        } else if (temperature >= 35) {

            score += 15;

            reasons.append(
                    "High temperature may increase driver fatigue during long journeys. "
            );

        } else if (temperature <= 0) {

            score += 40;

            reasons.append(
                    "Freezing temperature may create slippery or icy road conditions. "
            );

        } else if (temperature <= 5) {

            score += 25;

            reasons.append(
                    "Very low temperature may create difficult driving conditions. "
            );

        } else if (temperature <= 10) {

            score += 10;

            reasons.append(
                    "Low temperature requires additional caution while driving. "
            );
        }


        // =================================================
        // FINAL ROAD SAFETY RESULT
        // =================================================

        String result;

        if (score >= 70) {

            result = "UNSAFE TO DRIVE";

        } else if (score >= 30) {

            result = "DRIVE WITH CAUTION";

        } else {

            result = "SAFE TO DRIVE";
        }


        // =================================================
        // DEFAULT REASON
        // =================================================

        if (reasons.length() == 0) {

            reasons.append(
                    "Current weather conditions indicate no major road safety hazards."
            );
        }


        // =================================================
        // RETURN RESULT
        // =================================================

        return result
                + "|"
                + score
                + "|"
                + reasons;
    }
}