package com.disaster.controller;

import java.io.IOException;

import com.disaster.weather.OpenWeatherService;
import com.disaster.weather.OpenWeatherParser;
import com.disaster.weather.WeatherData;

import com.disaster.intelligence.DisasterRiskService;
import com.disaster.intelligence.RoadSafetyService;
import com.disaster.intelligence.AutomaticDangerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/LiveRiskServlet")
public class LiveRiskServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String latitude =
                request.getParameter("lat");

        String longitude =
                request.getParameter("lon");


        if (latitude == null || longitude == null
                || latitude.isBlank()
                || longitude.isBlank()) {

            request.setAttribute(
                    "error",
                    "Location was not received."
            );

            request.getRequestDispatcher(
                    "/live-risk.jsp"
            ).forward(request, response);

            return;
        }


        try {

            // =====================================
            // GET REAL WEATHER
            // =====================================

            OpenWeatherService weatherService =
                    new OpenWeatherService();

            String json =
                    weatherService.getCurrentWeather(
                            latitude,
                            longitude
                    );


            // =====================================
            // PARSE WEATHER
            // =====================================

            OpenWeatherParser parser =
                    new OpenWeatherParser();

            WeatherData weather =
                    parser.parseCurrentWeather(json);


            // =====================================
            // DISASTER RISK
            // =====================================

            DisasterRiskService disasterService =
                    new DisasterRiskService();

            String disasterResult =
                    disasterService.calculateRisk(
                            weather.getTemperature(),
                            weather.getHumidity(),
                            weather.getRainfall(),
                            weather.getWindSpeed()
                    );


            // =====================================
            // ROAD SAFETY
            // =====================================

            RoadSafetyService roadService =
                    new RoadSafetyService();

            String roadResult =
                    roadService.checkDrivingSafety(
                            weather.getRainfall(),
                            weather.getWindSpeed(),
                            weather.getVisibilityKm()
                    );


            String disasterLevel =
                    disasterResult.split("\\|")[0];

            String roadLevel =
                    roadResult.split("\\|")[0];


            // =====================================
            // AUTOMATIC DANGER
            // =====================================

            AutomaticDangerService dangerService =
                    new AutomaticDangerService();

            boolean danger =
                    dangerService.isDangerous(
                            disasterLevel,
                            roadLevel
                    );


            // =====================================
            // SEND DATA TO JSP
            // =====================================

            request.setAttribute(
                    "latitude",
                    latitude
            );

            request.setAttribute(
                    "longitude",
                    longitude
            );

            request.setAttribute(
                    "temperature",
                    weather.getTemperature()
            );

            request.setAttribute(
                    "humidity",
                    weather.getHumidity()
            );

            request.setAttribute(
                    "rainfall",
                    weather.getRainfall()
            );

            request.setAttribute(
                    "windSpeed",
                    weather.getWindSpeed()
            );

            request.setAttribute(
                    "visibility",
                    weather.getVisibilityKm()
            );

            request.setAttribute(
                    "disasterResult",
                    disasterResult
            );

            request.setAttribute(
                    "roadResult",
                    roadResult
            );

            request.setAttribute(
                    "danger",
                    danger
            );


            request.getRequestDispatcher(
                    "/live-risk.jsp"
            ).forward(request, response);


        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Unable to analyze live weather risk."
            );

            request.getRequestDispatcher(
                    "/live-risk.jsp"
            ).forward(request, response);
        }
    }
}