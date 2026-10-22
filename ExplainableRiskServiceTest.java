
package com.disaster.intelligence;

public class ExplainableRiskServiceTest {

    public static void main(String[] args) {

        ExplainableRiskService service =
                new ExplainableRiskService();

        String result = service.explainRisk(
                28.0,  // Temperature in Celsius
                92.0,  // Humidity in percent
                52.0,  // Rainfall in mm
                4.0    // Wind speed in m/s
        );

        String[] values = result.split("\\|", -1);

        System.out.println("=== EXPLAINABLE RISK TEST ===");
        System.out.println("Risk Level: " + values[0]);
        System.out.println("Total Score: " + values[1]);
        System.out.println("Rainfall Contribution: " + values[2]);
        System.out.println("Humidity Contribution: " + values[3]);
        System.out.println("Temperature Contribution: " + values[4]);
        System.out.println("Wind Contribution: " + values[5]);
        System.out.println("Dominant Factor: " + values[6]);
        System.out.println("Recommendation: " + values[7]);
        System.out.println("Explanation: " + values[8]);
    }
}
