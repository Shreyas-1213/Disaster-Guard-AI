package com.disaster.weather;

public class WeatherData {

    private double temperature;
    private double humidity;
    private double rainfall;
    private double windSpeed;
    private double visibilityKm;

    public WeatherData(
            double temperature,
            double humidity,
            double rainfall,
            double windSpeed,
            double visibilityKm) {

        this.temperature = temperature;
        this.humidity = humidity;
        this.rainfall = rainfall;
        this.windSpeed = windSpeed;
        this.visibilityKm = visibilityKm;
    }

    public double getTemperature() {
        return temperature;
    }

    public double getHumidity() {
        return humidity;
    }

    public double getRainfall() {
        return rainfall;
    }

    public double getWindSpeed() {
        return windSpeed;
    }

    public double getVisibilityKm() {
        return visibilityKm;
    }
}