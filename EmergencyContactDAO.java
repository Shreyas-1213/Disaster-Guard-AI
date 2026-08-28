package com.disaster.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.disaster.util.DBConnection;

public class EmergencyContactDAO {

    public List<String> getEmergencyEmails(int userId) {

        List<String> emails = new ArrayList<>();

        String sql =
                "SELECT contact_email "
              + "FROM emergency_contacts "
              + "WHERE user_id = ? "
              + "AND contact_email IS NOT NULL "
              + "AND contact_email <> '' "
              + "ORDER BY contact_id ASC "
              + "LIMIT 3";

        try {

            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, userId);

            ResultSet result =
                    statement.executeQuery();

            while (result.next()) {

                String email =
                        result.getString("contact_email");

                emails.add(email);

                System.out.println(
                        "Emergency email found : " + email
                );
            }

            result.close();
            statement.close();
            connection.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return emails;
    }
}