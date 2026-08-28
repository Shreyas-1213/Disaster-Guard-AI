<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>4-Day Risk Forecast | DisasterGuard AI</title>

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #0f172a;
    color: white;
    text-align: center;
}

.container {
    width: 90%;
    max-width: 650px;
    margin: 70px auto;
    background: #1e293b;
    padding: 40px;
    border-radius: 15px;
}

h1 {
    color: #38bdf8;
}

button {
    padding: 15px 25px;
    background: #2563eb;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 18px;
    cursor: pointer;
}

#status {
    margin-top: 25px;
    color: #cbd5e1;
    font-size: 17px;
}
</style>
</head>

<body>

<div class="container">

    <h1>4-Day Smart Risk Forecast</h1>

    <p>
        Detect your current location and analyze
        disaster risk and road safety for the next 4 days.
    </p>

    <button onclick="startForecast()">
        Analyze My Location
    </button>

    <p id="status">
        Waiting for location...
    </p>

</div>

<script>

function startForecast() {

    const status =
        document.getElementById("status");

    status.innerHTML =
        "Detecting current location...";

    if (!navigator.geolocation) {

        status.innerHTML =
            "GPS is not supported by this browser.";

        return;
    }

    navigator.geolocation.getCurrentPosition(

        function(position) {

            const latitude =
                position.coords.latitude;

            const longitude =
                position.coords.longitude;

            status.innerHTML =
                "Location detected. Preparing 4-day forecast...";

            window.location.href =
                "<%= request.getContextPath() %>/FourDayRiskServlet"
                + "?lat="
                + encodeURIComponent(latitude)
                + "&lon="
                + encodeURIComponent(longitude);
        },

        function(error) {

            if (error.code === 1) {

                status.innerHTML =
                    "Location permission denied.";

            } else if (error.code === 2) {

                status.innerHTML =
                    "Current location unavailable.";

            } else if (error.code === 3) {

                status.innerHTML =
                    "Location request timed out.";

            } else {

                status.innerHTML =
                    "Unable to detect location.";
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