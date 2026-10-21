
package com.disaster.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.disaster.intelligence.DisasterIncident;
import com.disaster.intelligence.DisasterIncidentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DisasterIncidentServlet")
public class DisasterIncidentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final DisasterIncidentDAO incidentDAO =
            new DisasterIncidentDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        try {
            List<DisasterIncident> incidents =
                    incidentDAO.getAllIncidents();

            request.setAttribute("incidents", incidents);

            request.getRequestDispatcher(
                "/live-monitoring.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            getServletContext().log(
                "Unable to retrieve disaster incidents.", e
            );

            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Unable to load incident records. Check the server log."
            );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String incidentType = trim(request.getParameter("incidentType"));
        String location = trim(request.getParameter("location"));
        String severity = trim(request.getParameter("severity"));
        String description = trim(request.getParameter("description"));

        if (incidentType.isEmpty()
                || location.isEmpty()
                || severity.isEmpty()) {

            response.sendRedirect(
                request.getContextPath()
                + "/DisasterIncidentServlet?error=missing"
            );
            return;
        }

        if (!severity.equals("LOW")
                && !severity.equals("MEDIUM")
                && !severity.equals("HIGH")
                && !severity.equals("CRITICAL")) {

            response.sendRedirect(
                request.getContextPath()
                + "/DisasterIncidentServlet?error=severity"
            );
            return;
        }

        DisasterIncident incident = new DisasterIncident();

        incident.setIncidentType(incidentType);
        incident.setLocation(location);
        incident.setSeverity(severity);
        incident.setDescription(description);
        incident.setIncidentStatus("REPORTED");

        try {
            boolean saved = incidentDAO.addIncident(incident);

            if (saved) {
                response.sendRedirect(
                    request.getContextPath()
                    + "/DisasterIncidentServlet?success=created"
                );
            } else {
                response.sendRedirect(
                    request.getContextPath()
                    + "/DisasterIncidentServlet?error=save"
                );
            }

        } catch (SQLException e) {
            getServletContext().log(
                "Unable to save disaster incident.", e
            );

            response.sendRedirect(
                request.getContextPath()
                + "/DisasterIncidentServlet?error=database"
            );
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
