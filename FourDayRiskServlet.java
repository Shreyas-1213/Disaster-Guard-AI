package com.disaster.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.disaster.intelligence.DisasterRiskService;
import com.disaster.intelligence.FourDayRiskService;
import com.disaster.intelligence.RiskTrendService;
import com.disaster.intelligence.RoadSafetyService;

import com.disaster.weather.Forecast72HourParser;
import com.disaster.weather.Forecast72HourService;
import com.disaster.weather.ForecastData;
import com.disaster.weather.FourDayForecastService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/FourDayRiskServlet")
public class FourDayRiskServlet extends HttpServlet {

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

        if (latitude == null
                || longitude == null
                || latitude.isBlank()
                || longitude.isBlank()) {

            request.setAttribute(
                    "error",
                    "Location information was not received."
            );

            request.getRequestDispatcher(
                    "/four-day-risk.jsp"
            ).forward(request, response);

            return;
        }

        try {

            // ====================================
            // GET REAL FORECAST
            // ====================================

            Forecast72HourService forecastService =
                    new Forecast72HourService();

            String json =
                    forecastService.get72HourForecast(
                            latitude,
                            longitude
                    );

            // ====================================
            // PARSE FORECAST
            // ====================================

            Forecast72HourParser parser =
                    new Forecast72HourParser();

            List<ForecastData> forecasts =
                    parser.parse72Hours(json);

            // ====================================
            // GROUP INTO DAYS
            // ====================================

            FourDayForecastService dayService =
                    new FourDayForecastService();

            Map<LocalDate, List<ForecastData>> fourDays =
                    dayService.groupIntoFourDays(
                            forecasts
                    );

            // ====================================
            // RISK SERVICES
            // ====================================

            DisasterRiskService disasterService =
                    new DisasterRiskService();

            RoadSafetyService roadService =
                    new RoadSafetyService();

            FourDayRiskService riskService =
                    new FourDayRiskService();

            // Store formatted results
            List<Map<String, String>> dayResults =
                    new ArrayList<>();

            List<Integer> dailyScores =
                    new ArrayList<>();

            int dayNumber = 1;

            // ====================================
            // ANALYZE EACH DAY
            // ====================================

            for (Map.Entry<LocalDate,
                    List<ForecastData>> entry
                    : fourDays.entrySet()) {

                String result =
                        riskService.analyzeDay(
                                entry.getValue(),
                                disasterService,
                                roadService
                        );

                String[] parts =
                        result.split("\\|", 8);

                if (parts.length < 8) {
                    continue;
                }

                int score;

                try {

                    score =
                            Integer.parseInt(
                                    parts[1]
                            );

                } catch (Exception e) {

                    score = 0;
                }

                dailyScores.add(score);

                Map<String, String> day =
                        new LinkedHashMap<>();

                day.put(
                        "dayNumber",
                        String.valueOf(dayNumber)
                );

                day.put(
                        "date",
                        entry.getKey().toString()
                );

                day.put(
                        "riskLevel",
                        parts[0]
                );

                day.put(
                        "riskScore",
                        parts[1]
                );

                day.put(
                        "roadSafety",
                        parts[2]
                );

                day.put(
                        "rainfall",
                        parts[3]
                );

                day.put(
                        "wind",
                        parts[4]
                );

                day.put(
                        "temperature",
                        parts[5]
                );

                day.put(
                        "visibility",
                        parts[6]
                );

                day.put(
                        "reason",
                        parts[7]
                );

                dayResults.add(day);

                dayNumber++;
            }

            // ====================================
            // RISK TREND
            // ====================================

            RiskTrendService trendService =
                    new RiskTrendService();

            String trendResult =
                    trendService.analyzeTrend(
                            dailyScores
                    );

            String[] trendParts =
                    trendResult.split("\\|", 5);

            // ====================================
            // SEND DATA TO JSP
            // ====================================

            request.setAttribute(
                    "latitude",
                    latitude
            );

            request.setAttribute(
                    "longitude",
                    longitude
            );

            request.setAttribute(
                    "dayResults",
                    dayResults
            );

            if (trendParts.length >= 5) {

                request.setAttribute(
                        "riskTrend",
                        trendParts[0]
                );

                request.setAttribute(
                        "highestRisk",
                        trendParts[1]
                );

                request.setAttribute(
                        "highestScore",
                        trendParts[2]
                );

                request.setAttribute(
                        "highestRiskDay",
                        trendParts[3]
                );

                request.setAttribute(
                        "recommendation",
                        trendParts[4]
                );
            }

            request.getRequestDispatcher(
                    "/four-day-risk.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Unable to generate 4-day risk forecast."
            );

            request.getRequestDispatcher(
                    "/four-day-risk.jsp"
            ).forward(request, response);
        }
    }
}