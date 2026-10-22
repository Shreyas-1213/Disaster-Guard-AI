
package com.disaster.intelligence;

public class ExplainableRiskService {

    public String explainRisk(
            double temperature,
            double humidity,
            double rainfall,
            double windSpeed) {

        int rainfallScore = 0;
        int humidityScore = 0;
        int temperatureScore = 0;
        int windScore = 0;

        StringBuilder explanation = new StringBuilder();
        String dominantFactor = "No significant hazard factor detected";
        String recommendation =
                "Continue monitoring local conditions and official alerts.";

        // 1. Rainfall contribution: same thresholds as DisasterRiskService
        if (rainfall >= 50) {
            rainfallScore = 40;
            explanation.append("Heavy rainfall: +40 points. ");
        } else if (rainfall >= 25) {
            rainfallScore = 20;
            explanation.append("Moderate rainfall: +20 points. ");
        }

        // 2. Humidity contribution
        if (humidity >= 90) {
            humidityScore = 15;
            explanation.append("Very high humidity: +15 points. ");
        }

        // 3. Temperature contribution
        if (temperature >= 40) {
            temperatureScore = 25;
            explanation.append("Extreme temperature: +25 points. ");
        }

        // 4. Wind contribution
        if (windSpeed >= 15) {
            windScore = 30;
            explanation.append("Strong wind: +30 points. ");
        }

        // Calculate total using the existing scoring rules
        int totalScore = rainfallScore
                + humidityScore
                + temperatureScore
                + windScore;

        String riskLevel;

        if (totalScore >= 70) {
            riskLevel = "CRITICAL";
        } else if (totalScore >= 45) {
            riskLevel = "HIGH";
        } else if (totalScore >= 20) {
            riskLevel = "MEDIUM";
        } else {
            riskLevel = "LOW";
        }

        // Identify the largest contributing factor
        int maximum = Math.max(
                Math.max(rainfallScore, humidityScore),
                Math.max(temperatureScore, windScore));

        if (maximum > 0) {
            if (rainfallScore == maximum) {
                dominantFactor = "Heavy rainfall";
                recommendation =
                        "Avoid flooded roads and low-lying areas. "
                        + "Monitor local flood warnings.";
            } else if (windScore == maximum) {
                dominantFactor = "Strong wind";
                recommendation =
                        "Avoid exposed areas and unsecured structures. "
                        + "Monitor official weather warnings.";
            } else if (temperatureScore == maximum) {
                dominantFactor = "Extreme temperature";
                recommendation =
                        "Avoid strenuous outdoor activity, seek shade, "
                        + "and stay hydrated.";
            } else if (humidityScore == maximum) {
                dominantFactor = "Very high humidity";
                recommendation =
                        "Limit strenuous activity if conditions feel hot "
                        + "and humid, and stay hydrated.";
            }
        }

        if (explanation.length() == 0) {
            explanation.append(
                    "No configured high-risk weather threshold was triggered. ");
        }

        // Machine-readable output for future servlet integration
        return riskLevel
                + "|" + totalScore
                + "|" + rainfallScore
                + "|" + humidityScore
                + "|" + temperatureScore
                + "|" + windScore
                + "|" + dominantFactor
                + "|" + recommendation
                + "|" + explanation;
    }
}
