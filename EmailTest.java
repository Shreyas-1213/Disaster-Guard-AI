package com.disaster.test;

import com.disaster.service.EmailService;

public class EmailTest {

    public static void main(String[] args) {

        EmailService service =
                new EmailService();

        boolean result =
                service.sendEmergencyEmail(
                        "shreyashv1180@gmail.com",
                        "Bengaluru",
                        "12.9716",
                        "77.5946"
                );

        System.out.println(
                "Email Result = " + result
        );
    }
}