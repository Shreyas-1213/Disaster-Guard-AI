<%@ page contentType="text/html;charset=UTF-8" %>

<%
String latitude = (String) request.getAttribute("latitude");
String longitude = (String) request.getAttribute("longitude");
String location = (String) request.getAttribute("location");
String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Emergency SOS | DisasterGuard AI</title>

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

    border: 2px solid #dc2626;

}

.sos-icon {

    font-size: 70px;

}

h1 {

    color: #f87171;

}

.status {

    color: #22c55e;

    font-size: 22px;

    font-weight: bold;

    margin-bottom: 20px;

}

.location-box {

    background: #111827;

    padding: 25px;

    border-radius: 10px;

    margin-top: 25px;

    text-align: left;

}

.location-box h2 {

    text-align: center;

    color: #38bdf8;

}

.location-box p {

    font-size: 17px;

    margin: 15px 0;

}

.back {

    display: inline-block;

    margin-top: 25px;

    padding: 12px 25px;

    background: #2563eb;

    color: white;

    text-decoration: none;

    border-radius: 7px;

}

.error {

    color: #fecaca;

    background: #7f1d1d;

    padding: 15px;

    border-radius: 8px;

}

</style>

</head>

<body>

<div class="container">

    <div class="sos-icon">
        🚨
    </div>

    <h1>Emergency SOS</h1>


    <%
    if (error != null) {
    %>

        <div class="error">

            <%= error %>

        </div>

    <%
    }
    else if (latitude != null && longitude != null) {
    %>

        <div class="status">

            SOS ACTIVATED

        </div>


        <div class="location-box">

            <h2>📍 Current Location</h2>

            <p>

                <strong>Area:</strong>

                <%= location %>

            </p>


            <p>

                <strong>Latitude:</strong>

                <%= latitude %>

            </p>


            <p>

                <strong>Longitude:</strong>

                <%= longitude %>

            </p>

        </div>


        <p>

            Your emergency location has been captured successfully.

        </p>

    <%
    }
    else {
    %>

        <div class="error">

            Location information was not received.

        </div>

    <%
    }
    %>


    <a href="<%= request.getContextPath() %>/dashboard.jsp"
       class="back">

        Return to Dashboard

    </a>

</div>

</body>

</html>