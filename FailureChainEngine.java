package com.disaster.engine;

import com.disaster.model.FailureChain;

public class FailureChainEngine {

    public FailureChain analyze(
            double temperature,
            double humidity,
            double windSpeed,
            String weatherCondition) {

        String condition =
                weatherCondition.toLowerCase();

        // Heavy rain / storm
        if (condition.contains("rain")
                || condition.contains("storm")
                || condition.contains("thunder")) {

            return new FailureChain(
                    "Heavy Rain",
                    "Water Accumulation / Flood Risk",
                    "Road Blockage",
                    "Emergency Response Delay",
                    80
            );
        }

        // Strong wind
        if (windSpeed >= 15) {

            return new FailureChain(
                    "Strong Wind",
                    "Falling Objects / Infrastructure Stress",
                    "Road or Power Disruption",
                    "Emergency Access Difficulty",
                    75
            );
        }

        // High temperature
        if (temperature >= 38) {

            return new FailureChain(
                    "Extreme Heat",
                    "Heat Stress",
                    "Power / Water Demand Increase",
                    "Health Emergency Risk",
                    70
            );
        }

        // High humidity
        if (humidity >= 85) {

            return new FailureChain(
                    "High Humidity",
                    "Weather Instability",
                    "Reduced Visibility / Road Risk",
                    "Emergency Response Difficulty",
                    45
            );
        }

        // Normal conditions

        return new FailureChain(
                "Normal Conditions",
                "Low Secondary Hazard",
                "Low Infrastructure Impact",
                "Normal Emergency Response",
                15
        );
    }
}