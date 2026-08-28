package com.disaster.controller;
import com.disaster.location.LocationService;
import java.io.IOException;

import com.disaster.weather.WeatherService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/WeatherServlet")
public class WeatherServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String city = request.getParameter("city");

        String lat = request.getParameter("lat");

        String lon = request.getParameter("lon");

        WeatherService service = new WeatherService();

        String weather;

        // If GPS coordinates are received
        if (lat != null && lon != null) {

            System.out.println("Latitude : " + lat);
            System.out.println("Longitude: " + lon);

            LocationService locationService = new LocationService();

            String address = locationService.getAddress(lat, lon);

            weather = service.getWeatherByLocation(lat, lon);

            weather =
                    "<h3>📍 " + address + "</h3>"
                    + weather;

        }
        // Otherwise use city name
        else {

            System.out.println("City received : " + city);

            weather = service.getWeather(city);

        }

        request.setAttribute("weatherData", weather);

        request.getRequestDispatcher("weather.jsp")
               .forward(request, response);
    }
}