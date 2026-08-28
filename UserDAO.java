package com.disaster.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.disaster.model.User;
import com.disaster.util.DBConnection;

public class UserDAO {

    // LOGIN USER
    public User loginUser(String email, String password) {

        String sql =
                "SELECT * FROM users WHERE email = ? AND password = ?";

        try {

            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setString(1, email);
            statement.setString(2, password);

            ResultSet resultSet =
                    statement.executeQuery();

            if (resultSet.next()) {

                User user = new User();

                user.setName(
                        resultSet.getString("name")
                );

                user.setEmail(
                        resultSet.getString("email")
                );

                user.setPassword(
                        resultSet.getString("password")
                );

                resultSet.close();
                statement.close();
                connection.close();

                return user;
            }

            resultSet.close();
            statement.close();
            connection.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    // REGISTER NEW USER
 // REGISTER NEW USER
    public boolean registerUser(User user) {

        String sql =
            "INSERT INTO users(name,email,password) VALUES(?,?,?)";

        try {

            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());

            int rows = statement.executeUpdate();

            statement.close();
            connection.close();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;
    }}