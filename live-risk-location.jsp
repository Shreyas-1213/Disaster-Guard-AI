<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>
Live Risk Analysis
</title>

</head>


<body style="
background:#0f172a;
color:white;
font-family:Arial;
text-align:center;
">


<h1>
DisasterGuard AI
</h1>

<h2>
Live Disaster & Road Safety Analysis
</h2>


<button
onclick="checkRisk()"
style="
padding:15px 25px;
font-size:18px;
background:#2563eb;
color:white;
border:none;
border-radius:8px;
">

Analyze Current Location

</button>


<p id="status">

Waiting for location...

</p>


<script>

function checkRisk() {

    const status =
        document.getElementById("status");


    status.innerHTML =
        "Detecting location...";


    navigator.geolocation.getCurrentPosition(

        function(position) {

            const latitude =
                position.coords.latitude;

            const longitude =
                position.coords.longitude;


            status.innerHTML =
                "Location detected. Analyzing...";


            window.location.href =

                "<%= request.getContextPath() %>/LiveRiskServlet"

                + "?lat="

                + encodeURIComponent(latitude)

                + "&lon="

                + encodeURIComponent(longitude);

        },


        function(error) {

            status.innerHTML =
                "Unable to detect location.";

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