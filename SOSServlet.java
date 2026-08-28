package com.disaster.controller;

import java.io.IOException;
import java.util.List;

import com.disaster.dao.EmergencyContactDAO;
import com.disaster.location.LocationService;
import com.disaster.service.EmailService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SOSServlet")
public class SOSServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String lat = request.getParameter("lat");
        String lon = request.getParameter("lon");

        System.out.println(
                "========== SOS ACTIVATED =========="
        );

        System.out.println("Latitude : " + lat);
        System.out.println("Longitude : " + lon);


        // ==============================
        // CHECK GPS
        // ==============================

        if (lat == null || lon == null
                || lat.trim().isEmpty()
                || lon.trim().isEmpty()) {

            request.setAttribute(
                    "error",
                    "Unable to obtain emergency location."
            );

            request.getRequestDispatcher("/sos-status.jsp")
                   .forward(request, response);

            return;
        }


        // ==============================
        // GET CURRENT AREA
        // ==============================

        LocationService locationService =
                new LocationService();

        String location =
                locationService.getAddress(lat, lon);

        System.out.println(
                "SOS Location : " + location
        );


        // ==============================
        // TEMPORARY USER ID
        // ==============================

        int userId = 1;


        // ==============================
        // GET EMERGENCY EMAILS
        // ==============================

        EmergencyContactDAO contactDAO =
                new EmergencyContactDAO();

        List<String> emergencyEmails =
                contactDAO.getEmergencyEmails(userId);


        // ==============================
        // SEND EMAIL TO ALL CONTACTS
        // ==============================

        int emailsSent = 0;

        EmailService emailService =
                new EmailService();

        if (emergencyEmails != null
                && !emergencyEmails.isEmpty()) {

            for (String emergencyEmail : emergencyEmails) {

                boolean sent =
                        emailService.sendEmergencyEmail(
                                emergencyEmail,
                                location,
                                lat,
                                lon
                        );

                System.out.println(
                        "SOS Email to "
                        + emergencyEmail
                        + " : "
                        + sent
                );

                if (sent) {
                    emailsSent++;
                }
            }

        } else {

            System.out.println(
                    "No emergency emails found."
            );
        }


        boolean emailSent =
                emailsSent > 0;


        System.out.println(
                "Total Emergency Emails Sent : "
                + emailsSent
        );


        // ==============================
        // SEND VALUES TO JSP
        // ==============================

        request.setAttribute(
                "latitude",
                lat
        );

        request.setAttribute(
                "longitude",
                lon
        );

        request.setAttribute(
                "location",
                location
        );

        request.setAttribute(
                "emailSent",
                emailSent
        );

        request.setAttribute(
                "emailsSent",
                emailsSent
        );


        request.getRequestDispatcher("/sos-status.jsp")
               .forward(request, response);
    }
}