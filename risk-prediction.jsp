<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>
AI Risk Prediction | DisasterGuard AI
</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #0f172a;
    color: white;
}

/* ============================= */
/* NAVBAR */
/* ============================= */

.navbar {

    background: #111827;

    padding: 20px 60px;

    display: flex;

    justify-content: space-between;

    align-items: center;

    border-bottom: 1px solid #1e293b;
}

.logo {

    font-size: 24px;

    font-weight: bold;
}

.logo span {

    color: #38bdf8;
}

.back-button {

    text-decoration: none;

    color: white;

    background: #2563eb;

    padding: 10px 18px;

    border-radius: 6px;
}

.back-button:hover {

    background: #1d4ed8;
}


/* ============================= */
/* PAGE CONTAINER */
/* ============================= */

.page-container {

    width: 90%;

    max-width: 950px;

    margin: 40px auto;
}


/* ============================= */
/* TITLE */
/* ============================= */

.page-title {

    text-align: center;

    margin-bottom: 35px;
}

.page-title h1 {

    color: #38bdf8;

    margin-bottom: 10px;
}

.page-title p {

    color: #94a3b8;

    line-height: 1.6;
}


/* ============================= */
/* LOCATION OPTIONS */
/* ============================= */

.location-section {

    background: #111827;

    border: 1px solid #1e293b;

    border-radius: 12px;

    padding: 30px;

    margin-bottom: 30px;
}

.location-section h2 {

    text-align: center;

    color: #38bdf8;

    margin-top: 0;

    margin-bottom: 8px;
}

.location-section-description {

    text-align: center;

    color: #94a3b8;

    margin-bottom: 25px;
}

.location-options {

    display: grid;

    grid-template-columns: repeat(2, 1fr);

    gap: 20px;
}

.location-card {

    background: #1e293b;

    border: 1px solid #334155;

    border-radius: 10px;

    padding: 25px;

    text-align: center;

    transition: 0.3s;
}

.location-card:hover {

    transform: translateY(-4px);

    border-color: #38bdf8;
}

.location-icon {

    font-size: 38px;

    margin-bottom: 12px;
}

.location-card h3 {

    color: #7dd3fc;

    margin-bottom: 10px;
}

.location-card p {

    color: #cbd5e1;

    line-height: 1.6;

    min-height: 55px;
}

.location-button {

    display: inline-block;

    margin-top: 10px;

    padding: 12px 20px;

    background: #2563eb;

    color: white;

    text-decoration: none;

    border-radius: 6px;

    font-weight: bold;
}

.location-button:hover {

    background: #1d4ed8;
}


/* ============================= */
/* DIVIDER */
/* ============================= */

.divider {

    display: flex;

    align-items: center;

    text-align: center;

    color: #64748b;

    margin: 30px 0;
}

.divider::before,
.divider::after {

    content: "";

    flex: 1;

    border-bottom: 1px solid #334155;
}

.divider span {

    padding: 0 15px;
}


/* ============================= */
/* MANUAL PREDICTION FORM */
/* ============================= */

.container {

    width: 100%;

    background: #1e293b;

    padding: 40px;

    border-radius: 12px;

    border: 1px solid #334155;
}

.container h2 {

    text-align: center;

    margin-top: 0;

    margin-bottom: 10px;

    color: #38bdf8;
}

.manual-description {

    text-align: center;

    color: #94a3b8;

    margin-bottom: 30px;
}

.form-group {

    margin-bottom: 20px;
}

label {

    display: block;

    margin-bottom: 8px;

    color: #e2e8f0;
}

input,
select {

    width: 100%;

    padding: 12px;

    border: 1px solid #334155;

    border-radius: 6px;

    background: #0f172a;

    color: white;

    font-size: 15px;
}

input:focus,
select:focus {

    outline: none;

    border-color: #38bdf8;
}

.predict-button {

    width: 100%;

    padding: 15px;

    background: #2563eb;

    color: white;

    border: none;

    border-radius: 6px;

    font-size: 18px;

    font-weight: bold;

    cursor: pointer;
}

.predict-button:hover {

    background: #1d4ed8;
}


/* ============================= */
/* RESPONSIVE */
/* ============================= */

@media(max-width: 700px) {

    .navbar {

        padding: 18px 20px;
    }

    .location-options {

        grid-template-columns: 1fr;
    }

    .container {

        padding: 25px;
    }
}

</style>

</head>


<body>


<!-- ============================= -->
<!-- NAVBAR -->
<!-- ============================= -->

<div class="navbar">

    <div class="logo">

        DisasterGuard <span>AI</span>

    </div>

    <a href="<%=request.getContextPath()%>/dashboard.jsp"
       class="back-button">

        Dashboard

    </a>

</div>


<div class="page-container">


    <!-- ============================= -->
    <!-- PAGE TITLE -->
    <!-- ============================= -->

    <div class="page-title">

        <h1>
            AI Disaster Risk Prediction
        </h1>

        <p>
            Analyse disaster and travel risk using
            your current location, a selected location
            on the map, or manual environmental data.
        </p>

    </div>


    <!-- ============================= -->
    <!-- LOCATION BASED PREDICTION -->
    <!-- ============================= -->

    <div class="location-section">

        <h2>
            Location-Based Risk Analysis
        </h2>

        <p class="location-section-description">
            Choose how you want DisasterGuard AI
            to analyse the location.
        </p>


        <div class="location-options">


            <!-- CURRENT LOCATION -->

            <div class="location-card">

                <div class="location-icon">
                    📍
                </div>

                <h3>
                    Use My Current Location
                </h3>

                <p>
                    Detect your GPS location automatically
                    and analyse live weather,
                    disaster risk and road safety.
                </p>

                <a href="<%=request.getContextPath()%>/live-risk-location.jsp"
                   class="location-button">

                    Use Current Location

                </a>

            </div>


            <!-- MAP LOCATION -->

            <div class="location-card">

                <div class="location-icon">
                    🗺️
                </div>

                <h3>
                    Select Location on Map
                </h3>

                <p>
                    Select any location on the interactive
                    map and analyse weather and disaster risk
                    for that point.
                </p>

                <a href="<%=request.getContextPath()%>/map-weather.jsp"
                   class="location-button">

                    Open Interactive Map

                </a>

            </div>


        </div>

    </div>


    <!-- ============================= -->
    <!-- DIVIDER -->
    <!-- ============================= -->

    <div class="divider">

        <span>
            OR ENTER DATA MANUALLY
        </span>

    </div>


    <!-- ============================= -->
    <!-- EXISTING MANUAL PREDICTION -->
    <!-- ============================= -->

    <div class="container">

        <h2>
            Manual Risk Prediction
        </h2>

        <p class="manual-description">
            Enter environmental values manually
            to calculate disaster risk.
        </p>


        <!-- IMPORTANT:
             Existing PredictionServlet flow
             remains unchanged.
        -->

        <form action="PredictionServlet"
              method="post">


            <div class="form-group">

                <label>
                    Location
                </label>

                <input type="text"
                       name="location"
                       required>

            </div>


            <div class="form-group">

                <label>
                    Disaster Type
                </label>

                <select name="disasterType">

                    <option>
                        Flood
                    </option>

                    <option>
                        Cyclone
                    </option>

                    <option>
                        Earthquake
                    </option>

                    <option>
                        Landslide
                    </option>

                    <option>
                        Drought
                    </option>

                </select>

            </div>


            <div class="form-group">

                <label>
                    Rainfall (mm)
                </label>

                <input type="number"
                       step="0.1"
                       name="rainfall"
                       required>

            </div>


            <div class="form-group">

                <label>
                    Temperature (°C)
                </label>

                <input type="number"
                       step="0.1"
                       name="temperature"
                       required>

            </div>


            <div class="form-group">

                <label>
                    Humidity (%)
                </label>

                <input type="number"
                       step="0.1"
                       name="humidity"
                       required>

            </div>


            <div class="form-group">

                <label>
                    Wind Speed (km/h)
                </label>

                <input type="number"
                       step="0.1"
                       name="windSpeed"
                       required>

            </div>


            <button type="submit"
                    class="predict-button">

                Predict Risk

            </button>


        </form>

    </div>


</div>


</body>

</html>