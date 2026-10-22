<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // Protect page from unauthenticated access
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Map Weather | DisasterGuard AI</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Leaflet CSS -->
<link rel="stylesheet"
      href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />

<style>

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: Arial, sans-serif;
        background: #0f172a;
        color: white;
        min-height: 100vh;
    }

    /* NAVBAR */

    .navbar {
        background: #111827;
        padding: 18px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #1f2937;
    }

    .navbar h2 {
        color: #38bdf8;
    }

    .navbar a {
        color: white;
        text-decoration: none;
        background: #2563eb;
        padding: 10px 18px;
        border-radius: 7px;
    }

    .navbar a:hover {
        background: #1d4ed8;
    }

    /* PAGE */

    .container {
        width: 92%;
        max-width: 1200px;
        margin: 35px auto;
    }

    .title-section {
        text-align: center;
        margin-bottom: 25px;
    }

    .title-section h1 {
        color: #38bdf8;
        margin-bottom: 10px;
    }

    .title-section p {
        color: #cbd5e1;
        line-height: 1.6;
    }

    /* MAP CARD */

    .map-card {
        background: #111827;
        padding: 22px;
        border-radius: 14px;
        border: 1px solid #1f2937;
    }

    #map {
        width: 100%;
        height: 500px;
        border-radius: 10px;
    }

    /* COORDINATES */

    .coordinates {
        margin-top: 20px;
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
    }

    .coordinate-box {
        background: #1e293b;
        padding: 18px;
        border-radius: 9px;
        text-align: center;
    }

    .coordinate-box span {
        color: #94a3b8;
        display: block;
        margin-bottom: 8px;
        font-size: 14px;
    }

    .coordinate-box strong {
        color: #38bdf8;
        font-size: 18px;
    }

    /* MESSAGE */

    .message {
        text-align: center;
        margin-top: 18px;
        color: #facc15;
        font-size: 16px;
    }

    /* BUTTON */

    .button-container {
        text-align: center;
        margin-top: 20px;
    }

    #weatherButton {
        background: #2563eb;
        color: white;
        border: none;
        padding: 13px 25px;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        display: none;
    }

    #weatherButton:hover {
        background: #1d4ed8;
    }

    @media(max-width: 700px) {

        .coordinates {
            grid-template-columns: 1fr;
        }

        #map {
            height: 400px;
        }

        .navbar {
            padding: 15px 20px;
        }
    }

</style>

</head>

<body>

<div class="navbar">

    <h2>DisasterGuard AI</h2>

    <a href="<%=request.getContextPath()%>/dashboard.jsp">
        Back to Dashboard
    </a>

</div>


<div class="container">

    <div class="title-section">

        <h1>Interactive Map Weather Analysis</h1>

        <p>
            Click anywhere on the map to select a location.
            DisasterGuard AI will use the selected latitude and longitude
            to analyze weather and safety conditions.
        </p>

    </div>


    <div class="map-card">

        <div id="map"></div>
        <div style="display:flex; gap:20px; flex-wrap:wrap;
            margin-top:15px; color:white; font-size:14px;">
    <span>🟢 Low Risk</span>
    <span>🟠 Medium Risk</span>
    <span>🔴 High Risk</span>
    <span>🚨 Critical Risk</span>
</div>


        <div class="coordinates">

            <div class="coordinate-box">

                <span>Selected Latitude</span>

                <strong id="latitude">
                    Not selected
                </strong>

            </div>


            <div class="coordinate-box">

                <span>Selected Longitude</span>

                <strong id="longitude">
                    Not selected
                </strong>

            </div>

        </div>


        <div class="message" id="message">

            Click any location on the map.

        </div>


        <div class="button-container">

            <button id="weatherButton">
                Check Weather & Risk
            </button>

        </div>

    </div>

</div>


<!-- Leaflet JavaScript -->

<script
src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js">
</script>


<script>

    /*
     * Initial map location
     * Bengaluru
     */

    var map = L.map('map').setView(
        [12.9716, 77.5946],
        6
    );


    /*
     * OpenStreetMap layer
     */

    L.tileLayer(
        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        {
            maxZoom: 19,
            attribution:
                '&copy; OpenStreetMap contributors'
        }
    ).addTo(map);


    /*
     * Marker variable
     */

    var selectedMarker = null;

    var selectedLatitude = null;

    var selectedLongitude = null;


    /*
     * Map click event
     */

    map.on('click', function(event) {

        selectedLatitude =
            event.latlng.lat.toFixed(6);

        selectedLongitude =
            event.latlng.lng.toFixed(6);


        /*
         * Show coordinates
         */

        document.getElementById("latitude")
            .innerText = selectedLatitude;

        document.getElementById("longitude")
            .innerText = selectedLongitude;


        /*
         * Remove previous marker
         */

        if (selectedMarker != null) {

            map.removeLayer(selectedMarker);

        }


        /*
         * Add marker at new location
         */

        selectedMarker = L.marker(
            [
                selectedLatitude,
                selectedLongitude
            ]
        ).addTo(map);


        selectedMarker.bindPopup(

            "<b>Selected Location</b><br>" +

            "Latitude: " +
            selectedLatitude +

            "<br>" +

            "Longitude: " +
            selectedLongitude

        ).openPopup();


        /*
         * Display message
         */

        document.getElementById("message")
            .innerHTML =
            "Location selected successfully.";


        /*
         * Show weather button
         */

        document.getElementById(
            "weatherButton"
        ).style.display = "inline-block";

    });


    /*
     * Weather button
     *
     * We will connect this to
     * MapWeatherServlet in Step 2.
     */

    document.getElementById(
        "weatherButton"
    ).addEventListener(
        "click",
        function() {

            if (
                selectedLatitude == null ||
                selectedLongitude == null
            ) {

                alert(
                    "Please select a location first."
                );

                return;
            }


            /*
             * Step 2 servlet URL
             */

            window.location.href =

                "<%=request.getContextPath()%>" +

                "/MapWeatherServlet" +

                "?lat=" +

                selectedLatitude +

                "&lon=" +

                selectedLongitude;

        }
    );

</script>

</body>
</html>