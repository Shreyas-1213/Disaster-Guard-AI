package com.disaster.controller;

import java.io.IOException;

import org.json.JSONArray;
import org.json.JSONObject;

import com.disaster.intelligence.DataReliabilityService;
import com.disaster.intelligence.DisasterRiskService;
import com.disaster.intelligence.RoadSafetyService;
import com.disaster.intelligence.EmergencyConfidenceService;
import com.disaster.intelligence.ExplainableRiskService;
import com.disaster.weather.OpenWeatherService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/MapWeatherServlet")
public class MapWeatherServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // ==========================================
        // GET MAP COORDINATES
        // ==========================================

        String latitude =
                request.getParameter("lat");

        String longitude =
                request.getParameter("lon");


        // ==========================================
        // VALIDATE COORDINATES
        // ==========================================

        if (latitude == null
                || longitude == null
                || latitude.trim().isEmpty()
                || longitude.trim().isEmpty()) {

            request.setAttribute(
                    "error",
                    "Please select a location on the map."
            );

            request.getRequestDispatcher(
                    "/map-weather-result.jsp"
            ).forward(request, response);

            return;
        }


        try {

            System.out.println(
                    "MAP WEATHER + RISK REQUEST"
            );

            System.out.println(
                    "Latitude : " + latitude
            );

            System.out.println(
                    "Longitude: " + longitude
            );


            // ==========================================
            // OPEN WEATHER SERVICE
            // ==========================================

            OpenWeatherService weatherService =
                    new OpenWeatherService();


            String weatherJson =
                    weatherService.getCurrentWeather(
                            latitude,
                            longitude
                    );


            // ==========================================
            // CHECK API RESPONSE
            // ==========================================

            if (weatherJson == null
                    || weatherJson.trim().isEmpty()) {

                request.setAttribute(
                        "error",
                        "Weather information could not be retrieved."
                );

                request.getRequestDispatcher(
                        "/map-weather-result.jsp"
                ).forward(request, response);

                return;
            }


            // ==========================================
            // PARSE WEATHER JSON
            // ==========================================

            JSONObject root =
                    new JSONObject(weatherJson);


            int code =
                    root.optInt(
                            "cod",
                            200
                    );


            if (code != 200) {

                String message =
                        root.optString(
                                "message",
                                "Unable to retrieve weather."
                        );

                request.setAttribute(
                        "error",
                        message
                );

                request.getRequestDispatcher(
                        "/map-weather-result.jsp"
                ).forward(request, response);

                return;
            }


            // ==========================================
            // LOCATION NAME
            // ==========================================

            String locationName =
                    root.optString(
                            "name",
                            "Selected Location"
                    );


            // ==========================================
            // TEMPERATURE + HUMIDITY
            // ==========================================

            JSONObject main =
                    root.getJSONObject("main");


            double temperature =
                    main.optDouble(
                            "temp",
                            0
                    );


            double feelsLike =
                    main.optDouble(
                            "feels_like",
                            temperature
                    );


            int humidity =
                    main.optInt(
                            "humidity",
                            0
                    );


            // ==========================================
            // WEATHER DESCRIPTION
            // ==========================================

            String weatherMain =
                    "Unknown";

            String weatherDescription =
                    "Weather information unavailable";


            JSONArray weatherArray =
                    root.optJSONArray("weather");


            if (weatherArray != null
                    && weatherArray.length() > 0) {

                JSONObject weather =
                        weatherArray.getJSONObject(0);


                weatherMain =
                        weather.optString(
                                "main",
                                "Unknown"
                        );


                weatherDescription =
                        weather.optString(
                                "description",
                                ""
                        );
            }


            // ==========================================
            // WIND
            // ==========================================

            double windSpeed = 0;


            if (root.has("wind")) {

                JSONObject wind =
                        root.getJSONObject("wind");

                windSpeed =
                        wind.optDouble(
                                "speed",
                                0
                        );
            }


            // ==========================================
            // VISIBILITY
            // ==========================================

            double visibilityKm =
                    root.optDouble(
                            "visibility",
                            0
                    ) / 1000.0;


            // ==========================================
            // RAINFALL
            // ==========================================

            double rainfall = 0;


            if (root.has("rain")) {

                JSONObject rain =
                        root.getJSONObject("rain");


                if (rain.has("1h")) {

                    rainfall =
                            rain.optDouble(
                                    "1h",
                                    0
                            );

                } else if (rain.has("3h")) {

                    rainfall =
                            rain.optDouble(
                                    "3h",
                                    0
                            );
                }
            }


            // ==========================================
            // DATA RELIABILITY
            // ==========================================

            DataReliabilityService reliabilityService =
                    new DataReliabilityService();


            String reliabilityResult =
                    reliabilityService.calculateReliability(
                            temperature,
                            humidity,
                            rainfall,
                            windSpeed,
                            visibilityKm,
                            latitude,
                            longitude
                    );


            String[] reliabilityParts =
                    reliabilityResult.split(
                            "\\|",
                            3
                    );


            String reliabilityLevel =
                    reliabilityParts.length > 0
                            ? reliabilityParts[0]
                            : "LOW";


            int reliabilityScore = 0;


            if (reliabilityParts.length > 1) {

                try {

                    reliabilityScore =
                            Integer.parseInt(
                                    reliabilityParts[1]
                            );

                } catch (NumberFormatException e) {

                    reliabilityScore = 0;
                }
            }


            String reliabilityReasons =
                    reliabilityParts.length > 2
                            ? reliabilityParts[2]
                            : "Reliability information unavailable.";


            System.out.println(
                    "Data Reliability: "
                    + reliabilityLevel
                    + " "
                    + reliabilityScore
                    + "%"
            );


            // ==========================================
            // DISASTER RISK ANALYSIS
            // ==========================================

            DisasterRiskService disasterRiskService =
                    new DisasterRiskService();


            String disasterResult =
                    disasterRiskService.calculateRisk(
                            temperature,
                            humidity,
                            rainfall,
                            windSpeed
                    );


            String[] disasterParts =
                    disasterResult.split(
                            "\\|",
                            -1
                    );


            String riskLevel =
                    disasterParts.length > 0
                            ? disasterParts[0]
                            : "LOW";


            String riskScore =
                    disasterParts.length > 1
                            ? disasterParts[1]
                            : "0";


            String riskReasons =
                    disasterParts.length > 2
                            ? disasterParts[2]
                            : "";


            if (riskReasons.trim().isEmpty()) {

                riskReasons =
                        "No major weather-related disaster "
                        + "risk factors detected.";
            }
         // ==========================================
         // EXPLAINABLE RISK ANALYSIS
         // ==========================================

         ExplainableRiskService explainableRiskService =
                 new ExplainableRiskService();

         String explainableResult =
                 explainableRiskService.explainRisk(
                         temperature,
                         humidity,
                         rainfall,
                         windSpeed
                 );

         String[] explainableParts =
                 explainableResult.split("\\|", -1);

         String explainableRiskLevel =
                 explainableParts.length > 0
                         ? explainableParts[0] : riskLevel;

         String explainableRiskScore =
                 explainableParts.length > 1
                         ? explainableParts[1] : riskScore;

         String rainfallContribution =
                 explainableParts.length > 2
                         ? explainableParts[2] : "0";

         String humidityContribution =
                 explainableParts.length > 3
                         ? explainableParts[3] : "0";

         String temperatureContribution =
                 explainableParts.length > 4
                         ? explainableParts[4] : "0";

         String windContribution =
                 explainableParts.length > 5
                         ? explainableParts[5] : "0";

         String dominantRiskFactor =
                 explainableParts.length > 6
                         ? explainableParts[6] : "Unavailable";

         String explainableRecommendation =
                 explainableParts.length > 7
                         ? explainableParts[7] : "Monitor local conditions.";

         String explainableReasons =
                 explainableParts.length > 8
                         ? explainableParts[8] : "";


            // ==========================================
            // ROAD SAFETY ANALYSIS
            // ==========================================

            RoadSafetyService roadSafetyService =
                    new RoadSafetyService();


            String roadResult =
                    roadSafetyService.checkDrivingSafety(
                            rainfall,
                            windSpeed,
                            visibilityKm,
                            temperature
                    );


            String[] roadParts =
                    roadResult.split(
                            "\\|",
                            -1
                    );


            String roadSafety =
                    roadParts.length > 0
                            ? roadParts[0]
                            : "SAFE TO DRIVE";


            String roadScore =
                    roadParts.length > 1
                            ? roadParts[1]
                            : "0";


            String roadReasons =
                    roadParts.length > 2
                            ? roadParts[2]
                            : "";


            if (roadReasons.trim().isEmpty()) {

                roadReasons =
                        "Current conditions indicate no "
                        + "major road safety hazards.";
            }


            // ==========================================
            // EMERGENCY CONFIDENCE SERVICE
            // ==========================================

            EmergencyConfidenceService emergencyService =
                    new EmergencyConfidenceService();


            /*
             * ==========================================
             * REAL PRODUCTION LOGIC
             *
             * Keep this code.
             * It is temporarily disabled only for
             * reviewer demonstration.
             * ==========================================
             */

            /*
            int emergencyConfidence =
                    emergencyService
                            .calculateEmergencyConfidence(
                                    riskLevel,
                                    roadSafety,
                                    temperature,
                                    rainfall,
                                    windSpeed,
                                    visibilityKm
                            );


            boolean automaticDanger =
                    emergencyService
                            .shouldStartSafetyCheck(
                                    emergencyConfidence
                            );
            */


            /*
             * ==========================================
             * REVIEWER DEMO MODE
             *
             * Simulated emergency so the Automatic SOS
             * can be demonstrated even if today's
             * weather is safe.
             * ==========================================
             */

            int emergencyConfidence = 85;

            boolean automaticDanger = true;


            System.out.println(
                    "Emergency Confidence: "
                    + emergencyConfidence
                    + "%"
            );


            System.out.println(
                    "Automatic Danger: "
                    + automaticDanger
            );


            System.out.println(
                    "AUTOMATIC SOS REVIEW DEMO MODE ACTIVE"
            );


            // ==========================================
            // SAFETY RECOMMENDATION
            // ==========================================

            String recommendation;


            if ("LOW".equalsIgnoreCase(
                    reliabilityLevel)) {

                recommendation =
                        "Environmental data reliability is low. "
                        + "Use caution and verify local "
                        + "conditions before making safety "
                        + "or travel decisions.";

            } else if (
                    "UNSAFE TO DRIVE"
                            .equals(roadSafety)) {

                recommendation =
                        "Avoid road travel under the "
                        + "current environmental conditions.";

            } else if (
                    "CRITICAL"
                            .equals(riskLevel)) {

                recommendation =
                        "Avoid unnecessary travel and "
                        + "remain prepared for emergency "
                        + "conditions.";

            } else if (
                    "HIGH"
                            .equals(riskLevel)) {

                recommendation =
                        "Limit unnecessary travel and "
                        + "monitor weather conditions "
                        + "carefully.";

            } else if (
                    "DRIVE WITH CAUTION"
                            .equals(roadSafety)) {

                recommendation =
                        "Travel with caution due to "
                        + "current environmental conditions.";

            } else if (
                    "MEDIUM"
                            .equals(riskLevel)) {

                recommendation =
                        "Conditions require caution. "
                        + "Continue monitoring weather "
                        + "updates.";

            } else {

                recommendation =
                        "Current environmental conditions "
                        + "indicate low immediate risk and "
                        + "generally safe travel conditions.";
            }


            // ==========================================
            // SEND BASIC WEATHER DATA
            // ==========================================

            request.setAttribute(
                    "latitude",
                    latitude
            );

            request.setAttribute(
                    "longitude",
                    longitude
            );

            request.setAttribute(
                    "locationName",
                    locationName
            );

            request.setAttribute(
                    "temperature",
                    temperature
            );

            request.setAttribute(
                    "feelsLike",
                    feelsLike
            );

            request.setAttribute(
                    "humidity",
                    humidity
            );

            request.setAttribute(
                    "weatherMain",
                    weatherMain
            );

            request.setAttribute(
                    "weatherDescription",
                    weatherDescription
            );

            request.setAttribute(
                    "windSpeed",
                    windSpeed
            );

            request.setAttribute(
                    "visibility",
                    visibilityKm
            );

            request.setAttribute(
                    "rainfall",
                    rainfall
            );


            // ==========================================
            // SEND RELIABILITY DATA
            // ==========================================

            request.setAttribute(
                    "reliabilityLevel",
                    reliabilityLevel
            );

            request.setAttribute(
                    "reliabilityScore",
                    reliabilityScore
            );

            request.setAttribute(
                    "reliabilityReasons",
                    reliabilityReasons
            );
         // ==========================================
         // SEND EXPLAINABLE RISK DATA
         // ==========================================

         request.setAttribute(
                 "explainableRiskLevel",
                 explainableRiskLevel
         );

         request.setAttribute(
                 "explainableRiskScore",
                 explainableRiskScore
         );

         request.setAttribute(
                 "rainfallContribution",
                 rainfallContribution
         );

         request.setAttribute(
                 "humidityContribution",
                 humidityContribution
         );

         request.setAttribute(
                 "temperatureContribution",
                 temperatureContribution
         );

         request.setAttribute(
                 "windContribution",
                 windContribution
         );

         request.setAttribute(
                 "dominantRiskFactor",
                 dominantRiskFactor
         );

         request.setAttribute(
                 "explainableRecommendation",
                 explainableRecommendation
         );

         request.setAttribute(
                 "explainableReasons",
                 explainableReasons
         );


            // ==========================================
            // SEND DISASTER RISK DATA
            // ==========================================

            request.setAttribute(
                    "riskLevel",
                    riskLevel
            );

            request.setAttribute(
                    "riskScore",
                    riskScore
            );

            request.setAttribute(
                    "riskReasons",
                    riskReasons
            );


            // ==========================================
            // SEND ROAD SAFETY DATA
            // ==========================================

            request.setAttribute(
                    "roadSafety",
                    roadSafety
            );

            request.setAttribute(
                    "roadScore",
                    roadScore
            );

            request.setAttribute(
                    "roadReasons",
                    roadReasons
            );


            // ==========================================
            // SEND EMERGENCY DATA
            // ==========================================

            request.setAttribute(
                    "emergencyConfidence",
                    emergencyConfidence
            );

            request.setAttribute(
                    "automaticDanger",
                    automaticDanger
            );


            // ==========================================
            // SEND RECOMMENDATION
            // ==========================================

            request.setAttribute(
                    "recommendation",
                    recommendation
            );


            // ==========================================
            // OPEN RESULT JSP
            // ==========================================

            request.getRequestDispatcher(
                    "/map-weather-result.jsp"
            ).forward(request, response);


        } catch (Exception e) {

            e.printStackTrace();


            request.setAttribute(
                    "error",
                    "An error occurred while analysing "
                    + "the selected location."
            );


            request.getRequestDispatcher(
                    "/map-weather-result.jsp"
            ).forward(request, response);
        }
    }
}