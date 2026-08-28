<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

<title>Dashboard | DisasterGuard AI</title>

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
    height: 75px;
    padding: 0 60px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #111827;
    border-bottom: 1px solid #1e293b;
}

.logo {
    font-size: 24px;
    font-weight: bold;
}

.logo span {
    color: #38bdf8;
}

.nav-links {
    display: flex;
    align-items: center;
    gap: 25px;
}

.nav-links a {
    color: #cbd5e1;
    text-decoration: none;
}

.nav-links a:hover {
    color: #38bdf8;
}

.logout {
    padding: 10px 18px;
    background: #dc2626;
    color: white !important;
    border-radius: 6px;
}


/* ============================= */
/* DASHBOARD */
/* ============================= */

.dashboard {
    padding: 50px 60px;
}

.welcome-section {
    margin-bottom: 45px;
}

.welcome-section h1 {
    font-size: 38px;
    margin-bottom: 10px;
}

.welcome-section h1 span {
    color: #38bdf8;
}

.welcome-section p {
    color: #94a3b8;
    font-size: 17px;
}


/* ============================= */
/* FEATURE CARDS */
/* ============================= */

.dashboard-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 25px;
}

.dashboard-card {
    background: #1e293b;
    border: 1px solid #334155;
    border-radius: 12px;
    padding: 30px;
    min-height: 230px;
    transition: 0.3s;
}

.dashboard-card:hover {
    transform: translateY(-5px);
    border-color: #38bdf8;
}

.dashboard-card h2 {
    color: #38bdf8;
    margin-bottom: 15px;
}

.dashboard-card p {
    color: #cbd5e1;
    line-height: 1.6;
}

.card-button {
    display: inline-block;
    margin-top: 15px;
    padding: 11px 20px;
    background: #2563eb;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    font-weight: bold;
}

.card-button:hover {
    background: #1d4ed8;
}


/* ============================= */
/* NEW 4-DAY FORECAST CARD */
/* ============================= */

.forecast-card {
    border: 1px solid #0ea5e9;
}

.forecast-card h2 {
    color: #7dd3fc;
}

.forecast-badge {
    display: inline-block;
    margin-bottom: 10px;
    padding: 5px 10px;
    background: #0c4a6e;
    color: #bae6fd;
    border-radius: 20px;
    font-size: 13px;
    font-weight: bold;
}


/* ============================= */
/* SYSTEM STATUS */
/* ============================= */

.status-section {
    margin-top: 40px;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 25px;
}

.status-card {
    background: #111827;
    padding: 25px;
    border-radius: 10px;
    border: 1px solid #1e293b;
}

.status-card h3 {
    color: #94a3b8;
    font-size: 15px;
}

.status-card p {
    color: #22c55e;
    font-size: 22px;
    font-weight: bold;
}


/* ============================= */
/* SOS SECTION */
/* ============================= */

.sos-container {
    width: 420px;
    max-width: 90%;
    margin: 40px auto;
    padding: 30px;
    text-align: center;
    background: #1e293b;
    border: 2px solid #dc2626;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.4);
}

.sos-container h2 {
    color: #f87171;
}

.sos-container p {
    color: #cbd5e1;
}

.sos-button {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    border: 6px solid #7f1d1d;
    background: #dc2626;
    color: white;
    font-size: 30px;
    font-weight: bold;
    cursor: pointer;
    box-shadow: 0 0 25px rgba(220,38,38,0.6);
}

.sos-button:hover {
    background: #ef4444;
}

#sosStatus {
    margin-top: 20px;
    font-weight: bold;
}


/* ============================= */
/* RESPONSIVE */
/* ============================= */

@media (max-width: 900px) {

    .dashboard-grid {
        grid-template-columns: 1fr;
    }

    .status-section {
        grid-template-columns: 1fr;
    }

    .navbar {
        padding: 0 25px;
    }

    .dashboard {
        padding: 35px 25px;
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

    <div class="nav-links">

        <a href="<%=request.getContextPath()%>/index.jsp">
            Home
        </a>

        <a href="<%=request.getContextPath()%>/logout.jsp"
           class="logout">
            Logout
        </a>

    </div>

</div>


<!-- ============================= -->
<!-- DASHBOARD -->
<!-- ============================= -->

<div class="dashboard">


    <!-- WELCOME -->

    <div class="welcome-section">

        <h1>
            Welcome to
            <span>DisasterGuard AI</span>
        </h1>

        <p>
            Your intelligent disaster management,
            risk monitoring and emergency response platform.
        </p>

    </div>


    <!-- ============================= -->
    <!-- MAIN FEATURES -->
    <!-- ============================= -->

    <div class="dashboard-grid">


        <!-- AI RISK PREDICTION -->

        <div class="dashboard-card">

            <h2>
                AI Risk Prediction
            </h2>

            <p>
                Analyse disaster risks using
                intelligent data-driven prediction
                and assessment.
            </p>

            <a href="<%=request.getContextPath()%>/risk-prediction.jsp"
               class="card-button">

                Analyse Risk

            </a>

        </div>


        <!-- LIVE MONITORING -->

        <div class="dashboard-card">

            <h2>
                Live Monitoring
            </h2>

            <p>
                Monitor disaster situations and
                important risk information in real time.
            </p>

            <a href="#"
               class="card-button">

                View Monitoring

            </a>

        </div>


        <!-- EMERGENCY SUPPORT -->

        <div class="dashboard-card">

            <h2>
                Emergency Support
            </h2>

            <p>
                Access emergency information,
                safety instructions and disaster
                preparedness resources.
            </p>

            <a href="#"
               class="card-button">

                Get Support

            </a>

        </div>


        <!-- LIVE WEATHER -->

        <div class="dashboard-card">

            <h2>
                Live Weather
            </h2>

            <p>
                Check real-time weather information
                using the OpenWeather service.
            </p>

            <a href="<%=request.getContextPath()%>/weather.jsp"
               class="card-button">

                Check Weather

            </a>

        </div>


        <!-- LIVE DISASTER & ROAD SAFETY -->

        <div class="dashboard-card">

            <h2>
                Live Disaster & Road Safety
            </h2>

            <p>
                Automatically detect your current
                location and analyse live weather,
                disaster risk, road safety and
                immediate danger conditions.
            </p>

            <a href="<%=request.getContextPath()%>/live-risk-location.jsp"
               class="card-button">

                Analyze Current Location

            </a>

        </div>


        <!-- ================================= -->
        <!-- NEW 4-DAY SMART RISK FORECAST -->
        <!-- ================================= -->

        <div class="dashboard-card forecast-card">

            <div class="forecast-badge">
                NEW INTELLIGENCE
            </div>

            <h2>
                4-Day Smart Risk Forecast
            </h2>

            <p>
                Automatically detect your location and
                forecast disaster risk, road safety,
                risk trend and travel recommendations
                for the next four days.
            </p>

            <a href="<%=request.getContextPath()%>/four-day-location.jsp"
               class="card-button">

                View 4-Day Forecast

            </a>

        </div>


    </div>


    <!-- ============================= -->
    <!-- SYSTEM STATUS -->
    <!-- ============================= -->

    <div class="status-section">

        <div class="status-card">

            <h3>
                System Status
            </h3>

            <p>
                ACTIVE
            </p>

        </div>


        <div class="status-card">

            <h3>
                AI Monitoring
            </h3>

            <p>
                ONLINE
            </p>

        </div>


        <div class="status-card">

            <h3>
                Emergency Network
            </h3>

            <p>
                READY
            </p>

        </div>

    </div>


</div>


<!-- ============================= -->
<!-- EMERGENCY SOS -->
<!-- ============================= -->

<div class="sos-container">

    <h2>
        🚨 Emergency SOS
    </h2>

    <p>
        Press SOS if you are in danger.
        Your current location will be
        captured automatically.
    </p>

    <button
        type="button"
        class="sos-button"
        onclick="activateSOS()">

        SOS

    </button>

    <p id="sosStatus"></p>

</div>


<!-- ============================= -->
<!-- SOS JAVASCRIPT -->
<!-- ============================= -->

<script>

function activateSOS() {

    const status =
        document.getElementById(
            "sosStatus"
        );

    status.innerHTML =
        "📍 Detecting your current location...";

    if (!navigator.geolocation) {

        status.innerHTML =
            "❌ GPS is not supported by this browser.";

        return;
    }

    navigator.geolocation.getCurrentPosition(

        function(position) {

            const latitude =
                position.coords.latitude;

            const longitude =
                position.coords.longitude;

            status.innerHTML =
                "🚨 SOS activated. Sending location...";

            window.location.href =
                "<%=request.getContextPath()%>/SOSServlet"
                + "?lat="
                + encodeURIComponent(latitude)
                + "&lon="
                + encodeURIComponent(longitude);

        },

        function(error) {

            if (error.code === 1) {

                status.innerHTML =
                    "❌ Location permission denied.";

            } else if (error.code === 2) {

                status.innerHTML =
                    "❌ Current location unavailable.";

            } else if (error.code === 3) {

                status.innerHTML =
                    "❌ Location request timed out.";

            } else {

                status.innerHTML =
                    "❌ Unable to detect location.";
            }

        },

        {
            enableHighAccuracy: true,
            timeout: 10000,
            maximumAge: 0
        }
    );
}

</script>

</body>
</html>