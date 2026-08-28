package com.disaster.location;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

public class LocationService {

    public String getAddress(String lat, String lon) {

        try {

            String apiURL =
                    "https://nominatim.openstreetmap.org/reverse?format=json&lat="
                    + lat
                    + "&lon="
                    + lon;

            URL url = new URL(apiURL);

            HttpURLConnection connection =
                    (HttpURLConnection) url.openConnection();

            connection.setRequestMethod("GET");

            // Required by Nominatim
            connection.setRequestProperty("User-Agent", "DisasterGuardAI");

            BufferedReader reader =
                    new BufferedReader(
                            new InputStreamReader(connection.getInputStream()));

            StringBuilder response = new StringBuilder();

            String line;

            while ((line = reader.readLine()) != null) {

                response.append(line);

            }

            reader.close();

            JSONObject json = new JSONObject(response.toString());

            JSONObject address = json.getJSONObject("address");

            String area = "";

            if(address.has("neighbourhood")){

                area = address.getString("neighbourhood");

            }
            else if(address.has("residential")){

                area = address.getString("residential");

            }
            else if(address.has("quarter")){

                area = address.getString("quarter");

            }
            else if(address.has("suburb")){

                area = address.getString("suburb");

            }
            else if(address.has("city_district")){

                area = address.getString("city_district");

            }
            else if(address.has("village")){

                area = address.getString("village");

            }
            else if(address.has("town")){

                area = address.getString("town");

            }
            else{

                area = address.getString("city");

            }

            String city = "";

            if(address.has("city")){

                city = address.getString("city");

            }
            else if(address.has("town")){

                city = address.getString("town");

            }
            System.out.println(json.toString(4));
            return area + ", " + city;

        }

        catch (Exception e) {

            e.printStackTrace();

            return "Location not found";

        }

    }

}