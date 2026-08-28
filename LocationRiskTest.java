package com.disaster.test;

import com.disaster.weather.OpenWeatherParser;
import com.disaster.weather.OpenWeatherService;
import com.disaster.weather.WeatherData;

import com.disaster.intelligence.DisasterRiskService;
import com.disaster.intelligence.RoadSafetyService;
import com.disaster.intelligence.AutomaticDangerService;

public class LocationRiskTest {

    public static void main(String[] args) {

        String latitude = "13.0147";
        String longitude = "77.5648";

        OpenWeatherService openWeatherService =
                new OpenWeatherService();

        String json =
                openWeatherService.getCurrentWeather(
                        latitude,
                        longitude
                );

        OpenWeatherParser parser =
                new OpenWeatherParser();

        WeatherData weather =
                parser.parseCurrentWeather(json);

        DisasterRiskService disasterService =
                new DisasterRiskService();

        RoadSafetyService roadService =
                new RoadSafetyService();

        AutomaticDangerService dangerService =
                new AutomaticDangerService();

        String disasterResult =
                disasterService.calculateRisk(
                        weather.getTemperature(),
                        weather.getHumidity(),
                        weather.getRainfall(),
                        weather.getWindSpeed()
                );

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

        boolean danger =
                dangerService.isDangerous(
                        disasterLevel,
                        roadLevel
                );

        System.out.println(
                "Temperature : "
                + weather.getTemperature()
        );

        System.out.println(
                "Humidity : "
                + weather.getHumidity()
        );

        System.out.println(
                "Rainfall : "
                + weather.getRainfall()
        );

        System.out.println(
                "Wind Speed : "
                + weather.getWindSpeed()
        );

        System.out.println(
                "Visibility : "
                + weather.getVisibilityKm()
        );

        System.out.println(
                "Disaster Risk : "
                + disasterResult
        );

        System.out.println(
                "Road Safety : "
                + roadResult
        );

        System.out.println(
                "Automatic Danger : "
                + danger
        );
    }
}