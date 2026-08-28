package com.disaster.service;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class SMSService {

    private static final String ACCOUNT_SID =
            System.getenv("TWILIO_ACCOUNT_SID");

    private static final String AUTH_TOKEN =
            System.getenv("TWILIO_AUTH_TOKEN");

    private static final String TWILIO_PHONE =
            System.getenv("TWILIO_PHONE_NUMBER");

    public boolean sendEmergencySMS(
            String emergencyPhone,
            String location,
            String latitude,
            String longitude) {

        try {

            System.out.println(
                    "ACCOUNT SID available: "
                    + (ACCOUNT_SID != null)
            );

            System.out.println(
                    "AUTH TOKEN available: "
                    + (AUTH_TOKEN != null)
            );

            System.out.println(
                    "TWILIO PHONE available: "
                    + (TWILIO_PHONE != null)
            );

            Twilio.init(
                    ACCOUNT_SID,
                    AUTH_TOKEN
            );

            /*
             * Twilio trial accounts currently allow
             * predefined SMS template names only.
             *
             * So for trial testing we use:
             * sms_internal_alerts
             */

            String messageText =
                    "sms_internal_alerts";

            Message message =
                    Message.creator(
                            new PhoneNumber(emergencyPhone),
                            new PhoneNumber(TWILIO_PHONE),
                            messageText
                    ).create();

            System.out.println(
                    "Twilio Message SID : "
                    + message.getSid()
            );

            System.out.println(
                    "Twilio Status : "
                    + message.getStatus()
            );

            /*
             * We still print the location in Eclipse
             * so we know GPS data is available.
             */

            String mapLink =
                    "https://maps.google.com/?q="
                    + latitude
                    + ","
                    + longitude;

            System.out.println(
                    "SOS Area : "
                    + location
            );

            System.out.println(
                    "SOS Map : "
                    + mapLink
            );

            return true;

        } catch (Exception e) {

            System.out.println(
                    "SMS sending failed."
            );

            e.printStackTrace();

            return false;
        }
    }
}