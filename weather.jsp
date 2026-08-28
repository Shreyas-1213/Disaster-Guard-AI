<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Live Weather</title>

<style>

body{
    font-family:Arial;
    background:#0f172a;
    color:white;
    text-align:center;
    padding:40px;
}

input{

    padding:12px;
    width:250px;

}

button{

    padding:12px 20px;
    background:#2563eb;
    color:white;
    border:none;
    cursor:pointer;

}

pre{

    margin-top:30px;
    background:#1e293b;
    padding:20px;
    border-radius:10px;
    text-align:left;
}
.weather-card{

    width:450px;

    margin:30px auto;

    background:#1e293b;

    border-radius:12px;

    padding:25px;

    text-align:left;

    box-shadow:0px 5px 15px rgba(0,0,0,0.4);

}

.weather-card h2{

    color:#38bdf8;

    text-align:center;

}

.weather-card p{

    font-size:18px;

    margin:12px 0;

    color:white;

}

</style>

</head>

<body>

<h1>Live Weather</h1>

<form action="WeatherServlet" method="get">

<input
type="text"
name="city"
placeholder="Enter City Name"
required>

<button type="submit">

Get Weather

</button>

</form>
<br><br>

<button onclick="getLocation()">

📍 Use My Current Location

</button>
<%
String data=(String)request.getAttribute("weatherData");

if(data!=null){
%>

<div class="weather-card">

    <%= data %>

</div>
<%
if (data != null) {
%>

<div style="margin-top:25px;">

    <form action="IntelligenceServlet" method="get">

        <%
        String city =
            request.getParameter("city");

        String lat =
            request.getParameter("lat");

        String lon =
            request.getParameter("lon");
        %>

        <% if (city != null && !city.isEmpty()) { %>

            <input
                type="hidden"
                name="city"
                value="<%= city %>">

        <% } %>

        <% if (lat != null && lon != null) { %>

            <input
                type="hidden"
                name="lat"
                value="<%= lat %>">

            <input
                type="hidden"
                name="lon"
                value="<%= lon %>">

        <% } %>

        <button type="submit">
            🧠 Analyze Disaster Risk
        </button>

    </form>

</div>

<%
}
%>

<%
}
%>
<script>

function getLocation(){

    if(navigator.geolocation){

        navigator.geolocation.getCurrentPosition(showPosition);

    }

    else{

        alert("Geolocation is not supported.");

    }

}

function showPosition(position){

    var latitude = position.coords.latitude;

    var longitude = position.coords.longitude;

    window.location.href =
    "WeatherServlet?lat=" + latitude +
    "&lon=" + longitude;

}

</script>
</body>

</html>