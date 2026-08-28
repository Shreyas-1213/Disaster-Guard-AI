package com.disaster.service;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailService {

    private static final String SENDER_EMAIL =
            System.getenv("DISASTER_EMAIL");

    private static final String APP_PASSWORD =
            System.getenv("DISASTER_EMAIL_APP_PASSWORD");

    public boolean sendEmergencyEmail(
            String emergencyEmail,
            String location,
            String latitude,
            String longitude) {

        try {

            System.out.println(
                    "EMAIL available: "
                    + (SENDER_EMAIL != null)
            );

            System.out.println(
                    "APP PASSWORD available: "
                    + (APP_PASSWORD != null)
            );

            Properties properties = new Properties();

            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.host", "smtp.gmail.com");
            properties.put("mail.smtp.port", "587");

            Session session = Session.getInstance(
                    properties,
                    new Authenticator() {

                        @Override
                        protected PasswordAuthentication
                        getPasswordAuthentication() {

                            return new PasswordAuthentication(
                                    SENDER_EMAIL,
                                    APP_PASSWORD
                            );
                        }
                    }
            );

            String mapLink =
                    "https://maps.google.com/?q="
                    + latitude
                    + ","
                    + longitude;

            String messageText =
                    "DISASTERGUARD AI - EMERGENCY SOS\n\n"
                    + "An emergency SOS has been triggered.\n\n"
                    + "Current Area: "
                    + location
                    + "\n\n"
                    + "Latitude: "
                    + latitude
                    + "\n"
                    + "Longitude: "
                    + longitude
                    + "\n\n"
                    + "Live Location:\n"
                    + mapLink
                    + "\n\n"
                    + "Please contact the person immediately.";

            MimeMessage message =
                    new MimeMessage(session);

            message.setFrom(
                    new InternetAddress(SENDER_EMAIL)
            );

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(emergencyEmail)
            );

            message.setSubject(
                    "Emergency SOS - DisasterGuard AI"
            );

            message.setText(messageText);

            Transport.send(message);

            System.out.println(
                    "Emergency email sent successfully."
            );

            return true;

        } catch (Exception e) {

            System.out.println(
                    "Emergency email sending failed."
            );

            e.printStackTrace();

            return false;
        }
    }
}