package com.disaster.weather;

public class ForecastData {

    private String dateTime;
    private double temperature;
    private double humidity;
    private double rainfall;
    private double windSpeed;
    private double visibilityKm;

    public ForecastData(
            String dateTime,
            double temperature,
            double humidity,
            double rainfall,
            double windSpeed,
            double visibilityKm) {

        this.dateTime = dateTime;
        this.temperature = temperature;
        this.humidity = humidity;
        this.rainfall = rainfall;
        this.windSpeed = windSpeed;
        this.visibilityKm = visibilityKm;
    }

    public String getDateTime() {
        return dateTime;
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