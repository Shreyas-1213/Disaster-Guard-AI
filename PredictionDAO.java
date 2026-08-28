package com.disaster.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.disaster.model.Prediction;
import com.disaster.util.DBConnection;

public class PredictionDAO {

    public boolean savePrediction(Prediction prediction) {

        String sql = "INSERT INTO predictions "
                + "(user_email, location, disaster_type, rainfall, temperature, humidity, wind_speed, risk_level) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setString(1, prediction.getUserEmail());
            statement.setString(2, prediction.getLocation());
            statement.setString(3, prediction.getDisasterType());
            statement.setDouble(4, prediction.getRainfall());
            statement.setDouble(5, prediction.getTemperature());
            statement.setDouble(6, prediction.getHumidity());
            statement.setDouble(7, prediction.getWindSpeed());
            statement.setString(8, prediction.getRiskLevel());

            int rows = statement.executeUpdate();

            statement.close();
            connection.close();

            if (rows > 0) {

                System.out.println("Prediction Saved Successfully");

                return true;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }
}