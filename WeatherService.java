package com.disaster.weather;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

public class WeatherService {

    private static final String API_KEY = "be88dc6822224a2077b4b055021ef66a";

    // ==========================
    // WEATHER USING CITY NAME
    // ==========================
    public String getWeather(String city) {

        try {

            String cityName = city.trim();

            String apiURL =
                    "https://api.openweathermap.org/data/2.5/weather?q="
                    + cityName
                    + "&appid="
                    + API_KEY
                    + "&units=metric";

            System.out.println("Weather URL : " + apiURL);

            URL url = new URL(apiURL);

            HttpURLConnection connection =
                    (HttpURLConnection) url.openConnection();

            connection.setRequestMethod("GET");

            if (connection.getResponseCode() != 200) {
                return "<h3>❌ City not found.</h3>";
            }

            BufferedReader reader =
                    new BufferedReader(
                            new InputStreamReader(
                                    connection.getInputStream()));

            StringBuilder response = new StringBuilder();

            String line;

            while ((line = reader.readLine()) != null) {
                response.append(line);
            }

            reader.close();

            JSONObject json = new JSONObject(response.toString());
            System.out.println(json.toString(4));
            String cityResult = json.getString("name");
            String country = json.getJSONObject("sys").getString("country");

            double temp = json.getJSONObject("main").getDouble("temp");
            double feelsLike = json.getJSONObject("main").getDouble("feels_like");
            int humidity = json.getJSONObject("main").getInt("humidity");

            double wind = json.getJSONObject("wind").getDouble("speed");

            String weather =
                    json.getJSONArray("weather")
                        .getJSONObject(0)
                        .getString("description");

            return "<h2>📍 " + cityResult + ", " + country + "</h2>"
                    + "<p><b>🌡 Temperature:</b> " + temp + " °C</p>"
                    + "<p><b>🤗 Feels Like:</b> " + feelsLike + " °C</p>"
                    + "<p><b>☁ Weather:</b> " + weather + "</p>"
                    + "<p><b>💧 Humidity:</b> " + humidity + "%</p>"
                    + "<p><b>🌬 Wind Speed:</b> " + wind + " m/s</p>";

        } catch (Exception e) {

            e.printStackTrace();

            return "<h3>❌ Unable to fetch weather.</h3>";

        }

    }

    // ==========================
    // WEATHER USING GPS
    // ==========================
    public String getWeatherByLocation(String lat, String lon) {

        try {

            String apiURL =
                    "https://api.openweathermap.org/data/2.5/weather?lat="
                    + lat
                    + "&lon="
                    + lon
                    + "&appid="
                    + API_KEY
                    + "&units=metric";

            System.out.println("GPS Weather URL : " + apiURL);

            URL url = new URL(apiURL);

            HttpURLConnection connection =
                    (HttpURLConnection) url.openConnection();

            connection.setRequestMethod("GET");

            if (connection.getResponseCode() != 200) {
                return "<h3>❌ Unable to fetch GPS weather.</h3>";
            }

            BufferedReader reader =
                    new BufferedReader(
                            new InputStreamReader(
                                    connection.getInputStream()));

            StringBuilder response = new StringBuilder();

            String line;

            while ((line = reader.readLine()) != null) {
                response.append(line);
            }

            reader.close();

            JSONObject json = new JSONObject(response.toString());

            String city = json.getString("name");
            String country = json.getJSONObject("sys").getString("country");

            double temp = json.getJSONObject("main").getDouble("temp");
            double feelsLike = json.getJSONObject("main").getDouble("feels_like");
            int humidity = json.getJSONObject("main").getInt("humidity");

            double wind = json.getJSONObject("wind").getDouble("speed");

            String weather =
                    json.getJSONArray("weather")
                        .getJSONObject(0)
                        .getString("description");
            return "<p><b>🌡 Temperature:</b> " + temp + " °C</p>"
            + "<p><b>🤗 Feels Like:</b> " + feelsLike + " °C</p>"
            + "<p><b>☁ Weather:</b> " + weather + "</p>"
            + "<p><b>💧 Humidity:</b> " + humidity + "%</p>"
            + "<p><b>🌬 Wind Speed:</b> " + wind + " m/s</p>";

        } catch (Exception e) {

            e.printStackTrace();

            return "<h3>❌ Unable to fetch weather using GPS.</h3>";

        }

    }

}