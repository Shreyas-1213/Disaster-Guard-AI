<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // =========================================================
    // LOGIN PROTECTION
    // =========================================================

    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }


    // =========================================================
    // ERROR
    // =========================================================

    String error =
            (String) request.getAttribute("error");


    // =========================================================
    // AUTOMATIC SOS DATA
    // =========================================================

    Object confidenceObject =
            request.getAttribute("emergencyConfidence");

    int emergencyConfidence = 0;

    if (confidenceObject != null) {

        try {

            emergencyConfidence =
                    Integer.parseInt(
                            confidenceObject.toString()
                    );

        } catch (Exception e) {

            emergencyConfidence = 0;
        }
    }


    Object dangerObject =
            request.getAttribute("automaticDanger");

    boolean automaticDanger = false;

    if (dangerObject != null) {

        automaticDanger =
                Boolean.parseBoolean(
                        dangerObject.toString()
                );
    }


    // =========================================================
    // LOCATION
    // =========================================================

    String latitude =
            request.getAttribute("latitude") != null
                    ? request.getAttribute("latitude").toString()
                    : "";

    String longitude =
            request.getAttribute("longitude") != null
                    ? request.getAttribute("longitude").toString()
                    : "";


    // =========================================================
    // DATA RELIABILITY
    // =========================================================

    String reliabilityLevel =
            request.getAttribute("reliabilityLevel") != null
                    ? request.getAttribute("reliabilityLevel").toString()
                    : "UNKNOWN";


    int reliabilityScore = 0;

    Object reliabilityScoreObject =
            request.getAttribute("reliabilityScore");

    if (reliabilityScoreObject != null) {

        try {

            reliabilityScore =
                    Integer.parseInt(
                            reliabilityScoreObject.toString()
                    );

        } catch (Exception e) {

            reliabilityScore = 0;
        }
    }


    String reliabilityReasons =
            request.getAttribute("reliabilityReasons") != null
                    ? request.getAttribute("reliabilityReasons").toString()
                    : "Reliability information unavailable.";


    String reliabilityClass;

    if ("HIGH".equalsIgnoreCase(reliabilityLevel)) {

        reliabilityClass = "reliability-high";

    } else if ("MODERATE".equalsIgnoreCase(reliabilityLevel)) {

        reliabilityClass = "reliability-moderate";

    } else {

        reliabilityClass = "reliability-low";
    }

String explainableRiskLevel =
        request.getAttribute("explainableRiskLevel") != null
        ? request.getAttribute("explainableRiskLevel").toString()
        : "Unavailable";

String explainableRiskScore =
        request.getAttribute("explainableRiskScore") != null
        ? request.getAttribute("explainableRiskScore").toString()
        : "0";

String rainfallContribution =
        request.getAttribute("rainfallContribution") != null
        ? request.getAttribute("rainfallContribution").toString()
        : "0";

String humidityContribution =
        request.getAttribute("humidityContribution") != null
        ? request.getAttribute("humidityContribution").toString()
        : "0";

String temperatureContribution =
        request.getAttribute("temperatureContribution") != null
        ? request.getAttribute("temperatureContribution").toString()
        : "0";

String windContribution =
        request.getAttribute("windContribution") != null
        ? request.getAttribute("windContribution").toString()
        : "0";

String dominantRiskFactor =
        request.getAttribute("dominantRiskFactor") != null
        ? request.getAttribute("dominantRiskFactor").toString()
        : "Unavailable";

String explainableRecommendation =
        request.getAttribute("explainableRecommendation") != null
        ? request.getAttribute("explainableRecommendation").toString()
        : "Monitor local conditions and official alerts.";

String explainableReasons =
        request.getAttribute("explainableReasons") != null
        ? request.getAttribute("explainableReasons").toString()
        : "No explanation available.";

%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>
    Map Risk Analysis | DisasterGuard AI
</title>


<style>

/* =========================================================
   GLOBAL
   ========================================================= */

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


/* =========================================================
   NAVBAR
   ========================================================= */

.navbar {

    height: 70px;

    padding: 0 40px;

    display: flex;

    align-items: center;

    justify-content: space-between;

    background: #111827;

    border-bottom: 1px solid #1f2937;
}


.logo {

    color: #38bdf8;

    font-size: 22px;

    font-weight: bold;
}


.dashboard-button {

    text-decoration: none;

    background: #2563eb;

    color: white;

    padding: 10px 18px;

    border-radius: 7px;
}


.dashboard-button:hover {

    background: #1d4ed8;
}


/* =========================================================
   MAIN
   ========================================================= */

.container {

    width: 92%;

    max-width: 1100px;

    margin: 35px auto 60px auto;
}


/* =========================================================
   HEADING
   ========================================================= */

.heading {

    text-align: center;

    margin-bottom: 30px;
}


.heading h1 {

    color: #38bdf8;

    margin-bottom: 10px;
}


.heading p {

    color: #94a3b8;

    line-height: 1.6;
}


/* =========================================================
   LOCATION
   ========================================================= */

.location-card {

    background: #111827;

    padding: 25px;

    border-radius: 14px;

    border: 1px solid #1f2937;

    margin-bottom: 25px;
}


.location-title {

    font-size: 23px;

    color: #38bdf8;

    margin-bottom: 12px;
}


.coordinates {

    color: #94a3b8;

    line-height: 1.8;
}


/* =========================================================
   SECTION TITLE
   ========================================================= */

.section-title {

    margin-top: 35px;

    margin-bottom: 18px;

    font-size: 22px;

    color: #38bdf8;
}


/* =========================================================
   WEATHER
   ========================================================= */

.weather-grid {

    display: grid;

    grid-template-columns: repeat(3, 1fr);

    gap: 18px;
}


.weather-card {

    background: #111827;

    border: 1px solid #1f2937;

    border-radius: 13px;

    padding: 25px;

    min-height: 130px;
}


.weather-card span {

    display: block;

    color: #94a3b8;

    font-size: 14px;

    margin-bottom: 12px;
}


.weather-card strong {

    color: white;

    font-size: 22px;
}


.description {

    text-transform: capitalize;
}


/* =========================================================
   ANALYSIS
   ========================================================= */

.analysis-grid {

    display: grid;

    grid-template-columns: repeat(2, 1fr);

    gap: 20px;

    margin-top: 15px;
}


.analysis-card {

    background: #111827;

    border: 1px solid #1f2937;

    border-radius: 14px;

    padding: 25px;
}


.analysis-card h2 {

    color: #38bdf8;

    margin-bottom: 20px;
}


.analysis-row {

    margin-bottom: 18px;
}


.analysis-label {

    display: block;

    color: #94a3b8;

    font-size: 14px;

    margin-bottom: 7px;
}


.analysis-value {

    font-size: 21px;

    font-weight: bold;
}


.analysis-reason {

    color: #cbd5e1;

    line-height: 1.7;

    margin-top: 12px;
}


/* =========================================================
   DATA RELIABILITY
   ========================================================= */

.reliability-card {

    margin-top: 22px;

    background: #111827;

    border: 1px solid #334155;

    border-radius: 14px;

    padding: 27px;
}


.reliability-card h2 {

    color: #38bdf8;

    margin-bottom: 8px;
}


.reliability-subtitle {

    color: #94a3b8;

    margin-bottom: 22px;

    line-height: 1.6;
}


.reliability-top {

    display: flex;

    justify-content: space-between;

    align-items: center;

    gap: 20px;

    margin-bottom: 20px;

    flex-wrap: wrap;
}


.reliability-score {

    font-size: 38px;

    font-weight: bold;
}


.reliability-badge {

    padding: 9px 16px;

    border-radius: 20px;

    font-size: 14px;

    font-weight: bold;
}


.reliability-high {

    background: #052e16;

    color: #86efac;

    border: 1px solid #22c55e;
}


.reliability-moderate {

    background: #422006;

    color: #fde047;

    border: 1px solid #eab308;
}


.reliability-low {

    background: #450a0a;

    color: #fca5a5;

    border: 1px solid #ef4444;
}


.reliability-bar {

    width: 100%;

    height: 17px;

    background: #1e293b;

    border-radius: 20px;

    overflow: hidden;

    margin-bottom: 20px;
}


.reliability-fill {

    height: 100%;

    border-radius: 20px;

    transition: width 0.5s ease;

    background: #22c55e;
}


.reliability-information {

    background: #0f172a;

    border: 1px solid #1e293b;

    border-radius: 10px;

    padding: 18px;

    margin-top: 15px;
}


.reliability-information h3 {

    color: #e2e8f0;

    font-size: 16px;

    margin-bottom: 12px;
}


.reliability-information p {

    color: #cbd5e1;

    line-height: 1.7;
}


.reliability-note {

    margin-top: 16px;

    color: #94a3b8;

    font-size: 13px;

    line-height: 1.6;
}


/* =========================================================
   EMERGENCY CONFIDENCE
   ========================================================= */

.confidence-card {

    margin-top: 20px;

    background: #111827;

    border: 1px solid #334155;

    border-radius: 14px;

    padding: 26px;
}


.confidence-card h2 {

    color: #38bdf8;

    margin-bottom: 18px;
}


.confidence-score {

    font-size: 32px;

    font-weight: bold;

    margin-bottom: 15px;
}


.confidence-bar {

    width: 100%;

    height: 16px;

    background: #1e293b;

    border-radius: 20px;

    overflow: hidden;
}


.confidence-fill {

    height: 100%;

    background: #38bdf8;

    border-radius: 20px;

    transition: width 0.5s ease;
}


.confidence-description {

    color: #cbd5e1;

    margin-top: 14px;

    line-height: 1.6;
}


/* =========================================================
   RECOMMENDATION
   ========================================================= */

.recommendation-card {

    margin-top: 20px;

    padding: 26px;

    background: #111827;

    border: 1px solid #2563eb;

    border-radius: 14px;
}


.recommendation-card h2 {

    color: #38bdf8;

    margin-bottom: 14px;
}


.recommendation-card p {

    color: #e2e8f0;

    line-height: 1.8;

    font-size: 16px;
}


/* =========================================================
   SAFE MESSAGE
   ========================================================= */

.safe-message {

    display: none;

    margin-top: 20px;

    padding: 18px;

    border-radius: 10px;

    background: #052e16;

    border: 1px solid #22c55e;

    color: #bbf7d0;
}


/* =========================================================
   ACTION BUTTONS
   ========================================================= */

.actions {

    margin-top: 30px;

    display: flex;

    justify-content: center;

    gap: 15px;

    flex-wrap: wrap;
}


.action-button {

    text-decoration: none;

    padding: 13px 22px;

    border-radius: 8px;

    color: white;

    background: #2563eb;
}


.action-button:hover {

    background: #1d4ed8;
}


.secondary {

    background: #1e293b;
}


.secondary:hover {

    background: #334155;
}


/* =========================================================
   ERROR
   ========================================================= */

.error {

    background: #7f1d1d;

    border: 1px solid #ef4444;

    padding: 25px;

    border-radius: 12px;

    text-align: center;
}


.error h2 {

    margin-bottom: 10px;
}


/* =========================================================
   AUTOMATIC SOS
   ========================================================= */

.sos-overlay {

    display: none;

    position: fixed;

    top: 0;

    left: 0;

    width: 100%;

    height: 100%;

    background: rgba(0, 0, 0, 0.82);

    z-index: 9999;

    align-items: center;

    justify-content: center;

    padding: 20px;
}


.sos-modal {

    width: 100%;

    max-width: 520px;

    background: #111827;

    border: 2px solid #ef4444;

    border-radius: 18px;

    padding: 35px;

    text-align: center;

    box-shadow:
        0 0 35px rgba(239, 68, 68, 0.35);
}


.sos-icon {

    font-size: 52px;

    margin-bottom: 15px;
}


.sos-modal h2 {

    color: #ef4444;

    margin-bottom: 15px;

    font-size: 28px;
}


.sos-modal p {

    color: #e2e8f0;

    line-height: 1.7;

    margin-bottom: 12px;
}


.sos-confidence {

    font-size: 19px;

    font-weight: bold;

    color: #fbbf24;

    margin-top: 15px;
}


.countdown-label {

    margin-top: 24px;

    color: #cbd5e1;
}


.countdown {

    font-size: 62px;

    font-weight: bold;

    color: #ef4444;

    margin: 8px 0;
}


.countdown-text {

    color: #94a3b8;

    margin-bottom: 24px;
}


.safe-button {

    width: 100%;

    border: none;

    padding: 15px;

    border-radius: 9px;

    background: #16a34a;

    color: white;

    font-size: 18px;

    font-weight: bold;

    cursor: pointer;
}


.safe-button:hover {

    background: #15803d;
}


.sos-status {

    margin-top: 17px;

    color: #94a3b8;

    line-height: 1.5;
}


/* =========================================================
   RESPONSIVE
   ========================================================= */

@media(max-width: 800px) {

    .weather-grid {

        grid-template-columns: repeat(2, 1fr);
    }


    .analysis-grid {

        grid-template-columns: 1fr;
    }
}


@media(max-width: 550px) {

    .weather-grid {

        grid-template-columns: 1fr;
    }


    .navbar {

        padding: 0 18px;
    }


    .sos-modal {

        padding: 25px 18px;
    }
}

/* Explainable Risk Analysis */
.explainable-card {
    background: #111827;
    border: 1px solid #374151;
    border-radius: 14px;
    padding: 24px;
    margin: 24px 0;
    color: #f9fafb;
}

.explainable-card h2 {
    color: #38bdf8;
    margin-top: 0;
    margin-bottom: 10px;
}

.explainable-card h3 {
    color: #e5e7eb;
    margin-top: 24px;
    margin-bottom: 14px;
}

.explainable-subtitle {
    color: #94a3b8;
    line-height: 1.6;
    margin-bottom: 20px;
}

.explainable-summary {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 16px;
    margin: 20px 0;
}

.explainable-summary > div {
    background: #1f2937;
    border: 1px solid #374151;
    border-radius: 10px;
    padding: 16px;
}

.explainable-summary strong,
.explainable-summary .analysis-value {
    display: block;
    color: #38bdf8;
    font-size: 22px;
    font-weight: 700;
    margin-top: 8px;
    overflow-wrap: anywhere;
}

.contribution-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 12px;
}

.contribution-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    background: #1f2937;
    border: 1px solid #374151;
    border-radius: 8px;
    padding: 14px;
}

.contribution-item span {
    color: #d1d5db;
}

.contribution-item strong {
    color: #38bdf8;
    white-space: nowrap;
}

.explainable-detail {
    color: #d1d5db;
    line-height: 1.7;
    overflow-wrap: anywhere;
    margin-top: 18px;
}

.explainable-detail strong {
    color: #f9fafb;
}

@media (max-width: 600px) {
    .explainable-card {
        padding: 16px;
    }

    .explainable-summary,
    .contribution-grid {
        grid-template-columns: 1fr;
    }
}

</style>

</head>


<body>


<!-- ========================================================
     NAVBAR
     ======================================================== -->

<div class="navbar">

    <div class="logo">
        DisasterGuard AI
    </div>

    <a
        href="<%=request.getContextPath()%>/dashboard.jsp"
        class="dashboard-button">

        Dashboard

    </a>

</div>



<div class="container">


<%
if (error != null) {
%>


    <!-- ====================================================
         ERROR
         ==================================================== -->

    <div class="error">

        <h2>
            Unable to Analyse Location
        </h2>

        <p>
            <%= error %>
        </p>


        <div class="actions">

            <a
                href="<%=request.getContextPath()%>/map-weather.jsp"
                class="action-button">

                Select Another Location

            </a>

        </div>

    </div>


<%
} else {
%>


<!-- ========================================================
     HEADING
     ======================================================== -->

<div class="heading">

    <h1>
        Selected Location Risk Analysis
    </h1>

    <p>
        Live weather, disaster risk, road safety,
        data reliability and emergency intelligence
        for the selected location.
    </p>

</div>



<!-- ========================================================
     LOCATION
     ======================================================== -->
     
<!-- ===== DisasterGuard AI Alert Panel: START ===== -->
<%
    String alertRiskLevel = request.getAttribute("riskLevel") != null
            ? request.getAttribute("riskLevel").toString().trim().toUpperCase()
            : "UNKNOWN";

    String alertBackground;
    String alertBorder;
    String alertTitle;
    String alertMessage;
    String alertSymbol;

    if ("CRITICAL".equals(alertRiskLevel)) {
        alertBackground = "#450a0a";
        alertBorder = "#ef4444";
        alertTitle = "CRITICAL DISASTER RISK";
        alertMessage = "Take immediate precautions. Move away from danger and follow official emergency instructions.";
        alertSymbol = "🚨";
    } else if ("HIGH".equals(alertRiskLevel)) {
        alertBackground = "#451a03";
        alertBorder = "#f97316";
        alertTitle = "HIGH DISASTER RISK";
        alertMessage = "Potentially dangerous conditions detected. Avoid exposed or unsafe areas and monitor official alerts.";
        alertSymbol = "🔴";
    } else if ("MEDIUM".equals(alertRiskLevel)) {
        alertBackground = "#422006";
        alertBorder = "#eab308";
        alertTitle = "MODERATE RISK — STAY ALERT";
        alertMessage = "Remain cautious, monitor changing conditions, and follow local safety guidance.";
        alertSymbol = "🟠";
    } else if ("LOW".equals(alertRiskLevel)) {
        alertBackground = "#052e16";
        alertBorder = "#22c55e";
        alertTitle = "LOW DISASTER RISK";
        alertMessage = "No elevated risk is indicated by the current risk assessment. Continue monitoring local conditions.";
        alertSymbol = "🟢";
    } else {
        alertBackground = "#1e293b";
        alertBorder = "#64748b";
        alertTitle = "RISK STATUS UNAVAILABLE";
        alertMessage = "A risk level could not be determined. Check the weather data and consult official local alerts.";
        alertSymbol = "ℹ️";
    }
%>

<div style="background:<%= alertBackground %>;
            border:1px solid <%= alertBorder %>;
            border-left:6px solid <%= alertBorder %>;
            border-radius:14px;
            padding:22px;
            margin:0 0 25px 0;
            color:#f8fafc;">

    <div style="display:flex; align-items:center; gap:12px;
                margin-bottom:12px; flex-wrap:wrap;">

        <span style="font-size:30px;">
            <%= alertSymbol %>
        </span>

        <h2 style="font-size:20px; margin:0;">
            <%= alertTitle %>
        </h2>
    </div>

    <p style="font-size:15px; line-height:1.8; margin:0 0 12px 0;">
        <%= alertMessage %>
    </p>

    <div style="font-size:12px; color:#cbd5e1;">
        Based on the current DisasterGuard AI risk assessment.
        This is an advisory, not an official emergency warning.
    </div>
</div>
<!-- ===== DisasterGuard AI Alert Panel: END ===== -->
     

<div class="location-card">

    <div class="location-title">

        📍
        <%= request.getAttribute("locationName") %>

    </div>


    <div class="coordinates">

        Latitude:
        <%= request.getAttribute("latitude") %>

        <br>

        Longitude:
        <%= request.getAttribute("longitude") %>

    </div>

</div>



<!-- ========================================================
     WEATHER
     ======================================================== -->

<h2 class="section-title">
    Live Weather Conditions
</h2>


<div class="weather-grid">


    <div class="weather-card">

        <span>
            Temperature
        </span>

        <strong>
            <%= request.getAttribute("temperature") %> °C
        </strong>

    </div>


    <div class="weather-card">

        <span>
            Feels Like
        </span>

        <strong>
            <%= request.getAttribute("feelsLike") %> °C
        </strong>

    </div>


    <div class="weather-card">

        <span>
            Humidity
        </span>

        <strong>
            <%= request.getAttribute("humidity") %> %
        </strong>

    </div>


    <div class="weather-card">

        <span>
            Weather
        </span>

        <strong>
            <%= request.getAttribute("weatherMain") %>
        </strong>

        <br><br>

        <span class="description">

            <%= request.getAttribute(
                    "weatherDescription"
            ) %>

        </span>

    </div>


    <div class="weather-card">

        <span>
            Rainfall
        </span>

        <strong>
            <%= request.getAttribute("rainfall") %> mm
        </strong>

    </div>


    <div class="weather-card">

        <span>
            Wind Speed
        </span>

        <strong>
            <%= request.getAttribute("windSpeed") %> m/s
        </strong>

    </div>


    <div class="weather-card">

        <span>
            Visibility
        </span>

        <strong>
            <%= request.getAttribute("visibility") %> km
        </strong>

    </div>


</div>



<!-- ========================================================
     DISASTERGUARD ANALYSIS
     ======================================================== -->

<h2 class="section-title">
    DisasterGuard Safety Analysis
</h2>


<div class="analysis-grid">


    <!-- ====================================================
         DISASTER RISK
         ==================================================== -->

    <div class="analysis-card">

        <h2>
            Disaster Risk
        </h2>


        <div class="analysis-row">

            <span class="analysis-label">
                Risk Level
            </span>

            <div class="analysis-value">

                <%= request.getAttribute(
                        "riskLevel"
                ) %>

            </div>

        </div>


        <div class="analysis-row">

            <span class="analysis-label">
                Risk Score
            </span>

            <div class="analysis-value">

                <%= request.getAttribute(
                        "riskScore"
                ) %>

            </div>

        </div>


        <div class="analysis-row">

            <span class="analysis-label">
                Reason
            </span>

            <div class="analysis-reason">

                <%= request.getAttribute(
                        "riskReasons"
                ) %>

            </div>

        </div>

    </div>



    <!-- ====================================================
         ROAD SAFETY
         ==================================================== -->

    <div class="analysis-card">

        <h2>
            Road Safety
        </h2>


        <div class="analysis-row">

            <span class="analysis-label">
                Driving Status
            </span>

            <div class="analysis-value">

                <%= request.getAttribute(
                        "roadSafety"
                ) %>

            </div>

        </div>


        <div class="analysis-row">

            <span class="analysis-label">
                Road Safety Score
            </span>

            <div class="analysis-value">

                <%= request.getAttribute(
                        "roadScore"
                ) %>

            </div>

        </div>


        <div class="analysis-row">

            <span class="analysis-label">
                Reason
            </span>

            <div class="analysis-reason">

                <%= request.getAttribute(
                        "roadReasons"
                ) %>

            </div>

        </div>

    </div>


</div>



<!-- ========================================================
     DATA RELIABILITY
     ======================================================== -->

<div class="reliability-card">

    <h2>
        Data Reliability Assessment
    </h2>


    <div class="reliability-subtitle">

        Evaluates the completeness and validity of
        environmental information before it is used
        for disaster-risk and safety analysis.

<!-- Explainable Risk Analysis Panel -->
<div class="explainable-card">
    <h2>Explainable Risk Analysis</h2>

    <p class="explainable-subtitle">
        Understand how each weather factor contributes to the rule-based disaster risk score.
    </p>

    <div class="explainable-summary">
        <div>
            <span>Explainable Risk Level</span>
            <div class="analysis-value"><%= explainableRiskLevel %></div>
        </div>

        <div>
            <span>Total Risk Score</span>
            <div class="analysis-value"><%= explainableRiskScore %> points</div>
        </div>
    </div>

    <h3>Weather Factor Contributions</h3>

    <div class="contribution-grid">
        <div class="contribution-item">
            <span>Rainfall</span>
            <strong><%= rainfallContribution %> points</strong>
        </div>

        <div class="contribution-item">
            <span>Humidity</span>
            <strong><%= humidityContribution %> points</strong>
        </div>

        <div class="contribution-item">
            <span>Temperature</span>
            <strong><%= temperatureContribution %> points</strong>
        </div>

        <div class="contribution-item">
            <span>Wind Speed</span>
            <strong><%= windContribution %> points</strong>
        </div>
    </div>

    <div class="explainable-detail">
        <p>
            <strong>Dominant Risk Factor:</strong>
            <%= dominantRiskFactor %>
        </p>

        <p>
            <strong>Reasoning:</strong>
            <%= explainableReasons %>
        </p>

        <p>
            <strong>Safety Recommendation:</strong>
            <%= explainableRecommendation %>
        </p>
    </div>
</div>
<!-- End Explainable Risk Analysis Panel -->

    </div>


    <div class="reliability-top">


        <div>

            <div class="analysis-label">
                Reliability Score
            </div>

            <div class="reliability-score">

                <%= reliabilityScore %>%

            </div>

        </div>


        <div class="reliability-badge <%= reliabilityClass %>">

            <%= reliabilityLevel %> RELIABILITY

        </div>


    </div>


    <div class="reliability-bar">

        <div
            class="reliability-fill"
            style="width: <%= reliabilityScore %>%;">
        </div>

    </div>


    <div class="reliability-information">

        <h3>
            Data Quality Assessment
        </h3>

        <p>
            <%= reliabilityReasons %>
        </p>

    </div>


    <div class="reliability-note">

        Note: The reliability percentage represents
        environmental data completeness and validity
        checks performed by DisasterGuard AI. It does
        not represent the absolute accuracy of the
        external weather provider.

    </div>

</div>



<!-- ========================================================
     EMERGENCY CONFIDENCE
     ======================================================== -->

<div class="confidence-card">

    <h2>
        Emergency Confidence
    </h2>


    <div class="confidence-score">

        <%= emergencyConfidence %>%

    </div>


    <div class="confidence-bar">

        <div
            class="confidence-fill"
            style="width: <%= emergencyConfidence %>%;">
        </div>

    </div>


    <div class="confidence-description">


        <%
        if (emergencyConfidence >= 90) {
        %>

            Very high emergency confidence.
            Immediate safety verification is required.

        <%
        } else if (emergencyConfidence >= 70) {
        %>

            Dangerous conditions detected.
            Automatic safety verification has been activated.

        <%
        } else if (emergencyConfidence >= 40) {
        %>

            Elevated environmental conditions detected.
            Continue monitoring your surroundings.

        <%
        } else {
        %>

            No immediate automatic emergency
            escalation is required.

        <%
        }
        %>


    </div>

</div>



<!-- ========================================================
     SAFETY RECOMMENDATION
     ======================================================== -->

<div class="recommendation-card">

    <h2>
        Safety Recommendation
    </h2>

    <p>

        <%= request.getAttribute(
                "recommendation"
        ) %>

    </p>

</div>



<!-- ========================================================
     SAFE CONFIRMATION MESSAGE
     ======================================================== -->

<div
    id="safeMessage"
    class="safe-message">

    Safety confirmed.
    Automatic SOS has been cancelled.

</div>



<!-- ========================================================
     BUTTONS
     ======================================================== -->

<div class="actions">

    <a
        href="<%=request.getContextPath()%>/map-weather.jsp"
        class="action-button">

        Select Another Location

    </a>


    <a
        href="<%=request.getContextPath()%>/dashboard.jsp"
        class="action-button secondary">

        Back to Dashboard

    </a>

</div>


<%
}
%>


</div>



<!-- ========================================================
     AUTOMATIC SOS MODAL
     ======================================================== -->

<%
if (error == null && automaticDanger) {
%>


<div
    id="sosOverlay"
    class="sos-overlay">


    <div class="sos-modal">


        <div class="sos-icon">
            ⚠️
        </div>


        <h2>
            Emergency Safety Check
        </h2>


        <p>

            DisasterGuard AI detected a combination
            of potentially dangerous environmental
            and travel conditions.

        </p>


        <div class="sos-confidence">

            Emergency Confidence:
            <%= emergencyConfidence %>%

        </div>


        <p class="countdown-label">

            Are you safe?

        </p>


        <div
            id="countdown"
            class="countdown">

            15

        </div>


        <div class="countdown-text">

            Automatic SOS will activate if
            you do not respond.

        </div>


        <button
            type="button"
            class="safe-button"
            onclick="confirmSafe()">

            I'M SAFE

        </button>


        <div
            id="sosStatus"
            class="sos-status">

            Waiting for your response...

        </div>


    </div>

</div>


<%
}
%>



<!-- ========================================================
     AUTOMATIC SOS JAVASCRIPT
     ======================================================== -->

<%
if (error == null && automaticDanger) {
%>


<script>


let secondsRemaining = 15;

let safetyConfirmed = false;

let sosTriggered = false;

let countdownTimer = null;



const sosOverlay =
        document.getElementById(
                "sosOverlay"
        );


const countdownElement =
        document.getElementById(
                "countdown"
        );


const sosStatus =
        document.getElementById(
                "sosStatus"
        );



/*
 * =========================================================
 * START SAFETY CHECK
 * =========================================================
 */

window.addEventListener(
        "load",
        function () {

            if (sosOverlay != null) {

                sosOverlay.style.display =
                        "flex";

                startSafetyCountdown();
            }
        }
);



/*
 * =========================================================
 * COUNTDOWN
 * =========================================================
 */

function startSafetyCountdown() {


    countdownElement.textContent =
            secondsRemaining;


    countdownTimer =
            setInterval(
                    function () {


                        if (safetyConfirmed) {

                            clearInterval(
                                    countdownTimer
                            );

                            return;
                        }


                        secondsRemaining--;


                        countdownElement.textContent =
                                secondsRemaining;


                        if (secondsRemaining <= 0) {

                            clearInterval(
                                    countdownTimer
                            );

                            triggerAutomaticSOS();
                        }

                    },

                    1000
            );
}



/*
 * =========================================================
 * USER CONFIRMS SAFETY
 * =========================================================
 */

function confirmSafe() {


    safetyConfirmed = true;


    if (countdownTimer != null) {

        clearInterval(
                countdownTimer
        );
    }


    sosStatus.textContent =
            "Safety confirmed. "
            + "Automatic SOS cancelled.";


    setTimeout(
            function () {


                sosOverlay.style.display =
                        "none";


                const safeMessage =
                        document.getElementById(
                                "safeMessage"
                        );


                if (safeMessage != null) {

                    safeMessage.style.display =
                            "block";
                }

            },

            800
    );
}



/*
 * =========================================================
 * AUTOMATIC SOS
 * =========================================================
 */

function triggerAutomaticSOS() {


    /*
     * Prevent duplicate SOS requests.
     */

    if (sosTriggered
            || safetyConfirmed) {

        return;
    }


    sosTriggered = true;


    countdownElement.textContent =
            "SOS";


    sosStatus.textContent =
            "No response received. "
            + "Activating emergency SOS...";


    /*
     * Current selected location.
     */

    const latitude =
            "<%= latitude %>";


    const longitude =
            "<%= longitude %>";


    /*
     * Existing SOSServlet.
     */

    const sosUrl =
            "<%=request.getContextPath()%>"
            + "/SOSServlet"
            + "?lat="
            + encodeURIComponent(latitude)
            + "&lon="
            + encodeURIComponent(longitude);


    /*
     * Small delay so user can see the
     * automatic escalation message.
     */

    setTimeout(
            function () {


                window.location.href =
                        sosUrl;

            },

            1000
    );
}


</script>


<%
}
%>

<!-- ===== DisasterGuard AI Risk Map: START ===== -->

<link rel="stylesheet"
      href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">

<div id="disasterRiskMapCard"
     style="background:#111827; padding:22px;
            border-radius:14px; margin:25px 0;
            border:1px solid #334155;">

    <h2 style="color:#38bdf8; margin-bottom:12px;">
        📍 Predicted Disaster Risk Map
    </h2>

    <p style="color:#cbd5e1; margin-bottom:15px;">
        The marker shows the predicted weather-related risk
        for your selected location.
    </p>

    <div id="disasterRiskMap"
         style="width:100%; height:400px; border-radius:10px;">
    </div>

    <p style="color:#e2e8f0; margin-top:15px;">
        🟢 LOW &nbsp; 🟠 MEDIUM &nbsp;
        🔴 HIGH &nbsp; 🚨 CRITICAL
    </p>
</div>

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<%
if (error == null) {
    String mapLevel = request.getAttribute("riskLevel") != null
        ? request.getAttribute("riskLevel").toString().trim().toUpperCase()
        : "LOW";

    String mapScore = request.getAttribute("riskScore") != null
        ? request.getAttribute("riskScore").toString()
        : "0";
%>

<script>
(function () {
    const lat = Number("<%= latitude %>");
    const lon = Number("<%= longitude %>");
    const level = "<%= mapLevel %>";
    const score = "<%= mapScore %>";

    const colors = {
        LOW: "#22c55e",
        MEDIUM: "#f97316",
        HIGH: "#ef4444",
        CRITICAL: "#dc2626"
    };

    const symbols = {
        LOW: "🟢",
        MEDIUM: "🟠",
        HIGH: "🔴",
        CRITICAL: "🚨"
    };

    const mapElement = document.getElementById("disasterRiskMap");

    if (!mapElement ||
        !Number.isFinite(lat) || !Number.isFinite(lon) ||
        lat < -90 || lat > 90 || lon < -180 || lon > 180) {
        if (mapElement) {
            mapElement.textContent = "Location coordinates are unavailable.";
        }
        return;
    }

    const map = L.map("disasterRiskMap").setView([lat, lon], 10);

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        maxZoom: 19,
        attribution: "&copy; OpenStreetMap contributors"
    }).addTo(map);

    const color = colors[level] || colors.LOW;
    const symbol = symbols[level] || symbols.LOW;


    const riskIcon = L.divIcon({
        className: "risk-map-icon",
        html: '<div style="background:' + color + ';width:42px;height:42px;border:3px solid white;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:23px;box-shadow:0 2px 10px rgba(0,0,0,.55);">' + symbol + '</div>',
        iconSize: [42, 42],
        iconAnchor: [21, 21],
        popupAnchor: [0, -22]
    });

    const marker = L.marker([lat, lon], {
        icon: riskIcon
    }).addTo(map);

    const popup = document.createElement("div");
    const title = document.createElement("strong");
    title.textContent = symbol + " " + level + " PREDICTED RISK";

    const scoreText = document.createElement("p");
    scoreText.textContent = "Risk score: " + score;

    popup.appendChild(title);
    popup.appendChild(scoreText);

    marker.bindPopup(popup).openPopup();

    setTimeout(function () {
        map.invalidateSize();
    }, 200);
})();
</script>

<%
}
%>

<!-- ===== DisasterGuard AI Risk Map: END ===== -->


</body>

</html>