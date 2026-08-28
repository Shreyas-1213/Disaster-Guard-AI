package com.disaster.test;

import com.disaster.service.SMSService;

public class SMSTest {

    public static void main(String[] args) {

        SMSService service =
                new SMSService();

        boolean result =
                service.sendEmergencySMS(
                        "+919606748248",
                        "Bengaluru",
                        "12.9716",
                        "77.5946"
                );

        System.out.println(
                "SMS Result = " + result
        );
    }
}