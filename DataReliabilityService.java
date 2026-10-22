package com.disaster.intelligence;

public class DataReliabilityService {

    public String calculateReliability(
            double temperature,
            double humidity,
            double rainfall,
            double windSpeed,
            double visibilityKm,
            String latitude,
            String longitude) {

        int score = 0;

        StringBuilder reasons =
                new StringBuilder();


        // ==============================
        // LOCATION CHECK
        // ==============================

        if (latitude != null
                && !latitude.isBlank()
                && longitude != null
                && !longitude.isBlank()) {

            score += 20;

        } else {

            reasons.append(
                    "Location coordinates are missing. "
            );
        }


        // ==============================
        // TEMPERATURE CHECK
        // ==============================

        if (temperature >= -60
                && temperature <= 60) {

            score += 20;

        } else {

            reasons.append(
                    "Temperature value appears invalid. "
            );
        }


        // ==============================
        // HUMIDITY CHECK
        // ==============================

        if (humidity >= 0
                && humidity <= 100) {

            score += 20;

        } else {

            reasons.append(
                    "Humidity value appears invalid. "
            );
        }


        // ==============================
        // WIND CHECK
        // ==============================

        if (windSpeed >= 0
                && windSpeed <= 100) {

            score += 20;

        } else {

            reasons.append(
                    "Wind speed value appears invalid. "
            );
        }


        // ==============================
        // VISIBILITY CHECK
        // ==============================

        if (visibilityKm >= 0
                && visibilityKm <= 100) {

            score += 20;

        } else {

            reasons.append(
                    "Visibility value appears invalid. "
            );
        }


        // ==============================
        // RELIABILITY LEVEL
        // ==============================

        String level;

        if (score >= 80) {

            level = "HIGH";

        } else if (score >= 60) {

            level = "MODERATE";

        } else {

            level = "LOW";
        }


        if (reasons.length() == 0) {

            reasons.append(
                    "All major environmental parameters "
                    + "are available and within expected ranges."
            );
        }


        return level
                + "|"
                + score
                + "|"
                + reasons;
    }
}