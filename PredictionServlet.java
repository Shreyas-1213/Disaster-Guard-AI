package com.disaster.controller;

import java.io.IOException;

import com.disaster.dao.PredictionDAO;
import com.disaster.model.Prediction;
import com.disaster.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PredictionServlet")
public class PredictionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        String location = request.getParameter("location");
        String disasterType = request.getParameter("disasterType");

        double rainfall =
                Double.parseDouble(request.getParameter("rainfall"));

        double temperature =
                Double.parseDouble(request.getParameter("temperature"));

        double humidity =
                Double.parseDouble(request.getParameter("humidity"));

        double windSpeed =
                Double.parseDouble(request.getParameter("windSpeed"));

        String riskLevel;

        // Simple AI Logic
        if (rainfall > 150 || windSpeed > 80 || humidity > 90) {

            riskLevel = "HIGH";

        } else if (rainfall > 80 || windSpeed > 50) {

            riskLevel = "MEDIUM";

        } else {

            riskLevel = "LOW";
        }

        Prediction prediction = new Prediction();

        prediction.setUserEmail(user.getEmail());
        prediction.setLocation(location);
        prediction.setDisasterType(disasterType);
        prediction.setRainfall(rainfall);
        prediction.setTemperature(temperature);
        prediction.setHumidity(humidity);
        prediction.setWindSpeed(windSpeed);
        prediction.setRiskLevel(riskLevel);

        PredictionDAO dao = new PredictionDAO();

        boolean saved = dao.savePrediction(prediction);

        if (saved) {

            request.setAttribute("prediction", prediction);

            request.getRequestDispatcher("prediction-result.jsp")
                   .forward(request, response);

        } else {

            response.sendRedirect("risk-prediction.jsp");
        }
    }
}