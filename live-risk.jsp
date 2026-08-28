<%@ page contentType="text/html;charset=UTF-8" %>

<%
String error =
        (String) request.getAttribute("error");

Double temperature =
        (Double) request.getAttribute("temperature");

Double humidity =
        (Double) request.getAttribute("humidity");

Double rainfall =
        (Double) request.getAttribute("rainfall");

Double windSpeed =
        (Double) request.getAttribute("windSpeed");

Double visibility =
        (Double) request.getAttribute("visibility");

String disasterResult =
        (String) request.getAttribute("disasterResult");

String roadResult =
        (String) request.getAttribute("roadResult");

Boolean danger =
        (Boolean) request.getAttribute("danger");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>
Live Risk | DisasterGuard AI
</title>

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

    max-width: 700px;

    margin: 60px auto;

    background: #1e293b;

    padding: 35px;

    border-radius: 15px;
}


h1 {

    color: #38bdf8;
}


.box {

    background: #111827;

    padding: 20px;

    margin-top: 20px;

    border-radius: 10px;

    text-align: left;
}


.good {

    color: #22c55e;

    font-weight: bold;
}


.danger {

    color: #f87171;

    font-weight: bold;
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

</style>

</head>


<body>


<div class="container">


<h1>
Live Disaster & Road Safety
</h1>


<%

if (error != null) {

%>


<div class="box danger">

    <%= error %>

</div>


<%

} else {

%>


<div class="box">

<h2>
Current Weather
</h2>

<p>
Temperature:
<%= temperature %> °C
</p>

<p>
Humidity:
<%= humidity %> %
</p>

<p>
Rainfall:
<%= rainfall %> mm
</p>

<p>
Wind Speed:
<%= windSpeed %> m/s
</p>

<p>
Visibility:
<%= visibility %> km
</p>

</div>



<div class="box">

<h2>
Disaster Risk
</h2>

<p>
<%= disasterResult %>
</p>

</div>



<div class="box">

<h2>
Road Safety
</h2>

<p>
<%= roadResult %>
</p>

</div>



<div class="box">

<h2>
Automatic Danger Detection
</h2>

<%

if (Boolean.TRUE.equals(danger)) {

%>

<p class="danger">

⚠ Dangerous conditions detected.

</p>

<%

} else {

%>

<p class="good">

✅ No immediate danger detected.

</p>

<%

}

%>

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