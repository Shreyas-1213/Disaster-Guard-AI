package com.disaster.intelligence;

public class AutomaticDangerService {

    public boolean isDangerous(
            String disasterRisk,
            String roadSafety) {

        if ("CRITICAL".equalsIgnoreCase(
                disasterRisk)) {

            return true;
        }

        if ("UNSAFE TO DRIVE".equalsIgnoreCase(
                roadSafety)) {

            return true;
        }

        return false;
    }
}