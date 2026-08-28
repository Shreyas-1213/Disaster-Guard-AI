package com.disaster.intelligence;

public class RoadSafetyService {

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

            result =
                    "UNSAFE TO DRIVE";

        } else if (score >= 30) {

            result =
                    "DRIVE WITH CAUTION";

        } else {

            result =
                    "SAFE TO DRIVE";
        }

        return result
                + "|"
                + reasons;
    }
}