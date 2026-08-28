package com.disaster.intelligence;

import java.util.List;

public class RiskTrendService {

    public String analyzeTrend(List<Integer> scores) {

        if (scores == null || scores.isEmpty()) {
            return "UNKNOWN|0|No forecast scores available.";
        }

        int highestScore = scores.get(0);
        int highestDayIndex = 0;

        for (int i = 0; i < scores.size(); i++) {

            if (scores.get(i) > highestScore) {
                highestScore = scores.get(i);
                highestDayIndex = i;
            }
        }

        String trend = "STABLE";

        int firstScore = scores.get(0);
        int lastScore = scores.get(scores.size() - 1);

        if (lastScore > firstScore) {
            trend = "INCREASING";
        }
        else if (lastScore < firstScore) {
            trend = "DECREASING";
        }

        String highestLevel;

        if (highestScore >= 70) {
            highestLevel = "CRITICAL";
        }
        else if (highestScore >= 45) {
            highestLevel = "HIGH";
        }
        else if (highestScore >= 20) {
            highestLevel = "MEDIUM";
        }
        else {
            highestLevel = "LOW";
        }

        String recommendation;

        if ("CRITICAL".equals(highestLevel)) {

            recommendation =
                    "Avoid unnecessary travel and remain prepared for emergency action.";

        }
        else if ("HIGH".equals(highestLevel)) {

            recommendation =
                    "Travel should be limited during the highest-risk period.";

        }
        else if ("MEDIUM".equals(highestLevel)) {

            recommendation =
                    "Travel with caution and continue monitoring weather conditions.";

        }
        else {

            recommendation =
                    "Current forecast indicates generally safe conditions.";
        }

        return trend
                + "|"
                + highestLevel
                + "|"
                + highestScore
                + "|"
                + (highestDayIndex + 1)
                + "|"
                + recommendation;
    }
}