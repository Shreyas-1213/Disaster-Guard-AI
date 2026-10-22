package com.disaster.intelligence;

public class EmergencyConfidenceService {

    public int calculateEmergencyConfidence(
            String riskLevel,
            String roadSafety,
            double temperature,
            double rainfall,
            double windSpeed,
            double visibilityKm) {

        int confidence = 0;


        // =========================================
        // DISASTER RISK CONTRIBUTION
        // =========================================

        if ("CRITICAL".equalsIgnoreCase(riskLevel)) {

            confidence += 40;

        } else if ("HIGH".equalsIgnoreCase(riskLevel)) {

            confidence += 30;

        } else if ("MEDIUM".equalsIgnoreCase(riskLevel)) {

            confidence += 15;
        }


        // =========================================
        // ROAD SAFETY CONTRIBUTION
        // =========================================

        if ("UNSAFE TO DRIVE".equalsIgnoreCase(roadSafety)) {

            confidence += 25;

        } else if ("DRIVE WITH CAUTION".equalsIgnoreCase(roadSafety)) {

            confidence += 10;
        }


        // =========================================
        // EXTREME TEMPERATURE
        // =========================================

        if (temperature >= 45) {

            confidence += 15;

        } else if (temperature <= 0) {

            confidence += 15;
        }


        // =========================================
        // HEAVY RAINFALL
        // =========================================

        if (rainfall >= 50) {

            confidence += 15;

        } else if (rainfall >= 25) {

            confidence += 8;
        }


        // =========================================
        // STRONG WIND
        // =========================================

        if (windSpeed >= 20) {

            confidence += 15;

        } else if (windSpeed >= 15) {

            confidence += 10;
        }


        // =========================================
        // LOW VISIBILITY
        // =========================================

        if (visibilityKm < 1) {

            confidence += 15;

        } else if (visibilityKm < 2) {

            confidence += 10;
        }


        // =========================================
        // LIMIT TO 100
        // =========================================

        if (confidence > 100) {

            confidence = 100;
        }


        return confidence;
    }


    public boolean shouldStartSafetyCheck(int confidence) {

        return confidence >= 70;
    }
}