<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
String error =
        (String) request.getAttribute("error");

List<Map<String, String>> dayResults =
        (List<Map<String, String>>)
        request.getAttribute("dayResults");

String riskTrend =
        (String) request.getAttribute("riskTrend");

String highestRisk =
        (String) request.getAttribute("highestRisk");

String highestScore =
        (String) request.getAttribute("highestScore");

String highestRiskDay =
        (String) request.getAttribute("highestRiskDay");

String recommendation =
        (String) request.getAttribute("recommendation");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>
4-Day Risk Forecast | DisasterGuard AI
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

.container {
    width: 92%;
    max-width: 1200px;
    margin: 45px auto;
}

h1 {
    text-align: center;
    color: #38bdf8;
}

.subtitle {
    text-align: center;
    color: #94a3b8;
    margin-bottom: 35px;
}

.forecast-grid {
    display: grid;
    grid-template-columns:
        repeat(4, 1fr);
    gap: 20px;
}

.day-card {
    background: #1e293b;
    border: 1px solid #334155;
    border-radius: 12px;
    padding: 22px;
}

.day-card h2 {
    color: #38bdf8;
}

.value {
    color: #cbd5e1;
    margin: 10px 0;
}

.low {
    color: #22c55e;
    font-weight: bold;
}

.medium {
    color: #facc15;
    font-weight: bold;
}

.high {
    color: #fb923c;
    font-weight: bold;
}

.critical {
    color: #f87171;
    font-weight: bold;
}

.summary {
    margin-top: 35px;
    background: #111827;
    border-radius: 12px;
    padding: 30px;
}

.summary h2 {
    color: #38bdf8;
}

.recommendation {
    margin-top: 20px;
    background: #1e293b;
    padding: 20px;
    border-radius: 8px;
}

.error {
    background: #7f1d1d;
    color: #fecaca;
    padding: 20px;
    border-radius: 10px;
}

.back {
    display: inline-block;
    margin-top: 30px;
    padding: 12px 22px;
    background: #2563eb;
    color: white;
    text-decoration: none;
    border-radius: 7px;
}

@media (max-width: 1000px) {

    .forecast-grid {
        grid-template-columns:
            repeat(2, 1fr);
    }
}

@media (max-width: 600px) {

    .forecast-grid {
        grid-template-columns:
            1fr;
    }
}

</style>

</head>


<body>


<div class="container">


<h1>
4-Day Personal Safety Forecast
</h1>


<p class="subtitle">

    Location-aware disaster risk
    and road safety intelligence

</p>


<%

if (error != null) {

%>


<div class="error">

    <%= error %>

</div>


<%

} else if (dayResults != null) {

%>


<div class="forecast-grid">


<%

for (Map<String, String> day : dayResults) {

    String risk =
            day.get("riskLevel");

    String cssClass =
            "low";

    if ("MEDIUM".equalsIgnoreCase(risk)) {

        cssClass =
                "medium";

    } else if ("HIGH".equalsIgnoreCase(risk)) {

        cssClass =
                "high";

    } else if ("CRITICAL".equalsIgnoreCase(risk)) {

        cssClass =
                "critical";
    }

%>


<div class="day-card">


<h2>

Day
<%= day.get("dayNumber") %>

</h2>


<p class="value">

Date:
<%= day.get("date") %>

</p>


<p>

Risk:

<span class="<%= cssClass %>">

<%= day.get("riskLevel") %>

</span>

</p>


<p class="value">

Risk Score:
<%= day.get("riskScore") %>

</p>


<p class="value">

Road Safety:
<strong>
<%= day.get("roadSafety") %>
</strong>

</p>


<p class="value">

Rainfall:
<%= day.get("rainfall") %>
mm

</p>


<p class="value">

Max Wind:
<%= day.get("wind") %>
m/s

</p>


<p class="value">

Max Temperature:
<%= day.get("temperature") %>
°C

</p>


<p class="value">

Min Visibility:
<%= day.get("visibility") %>
km

</p>


<p class="value">

Why?

<br>

<%= day.get("reason") %>

</p>


</div>


<%

}

%>


</div>



<div class="summary">


<h2>
4-Day Risk Intelligence
</h2>


<p>

Risk Trend:

<strong>
<%= riskTrend %>
</strong>

</p>


<p>

Highest Risk:

<strong>
<%= highestRisk %>
</strong>

</p>


<p>

Highest Risk Score:

<strong>
<%= highestScore %>
</strong>

</p>


<p>

Highest Risk Day:

<strong>
Day <%= highestRiskDay %>
</strong>

</p>


<div class="recommendation">

<h3>
Travel Recommendation
</h3>

<p>
<%= recommendation %>
</p>

</div>


</div>


<%

}

%>


<a href="<%=request.getContextPath()%>/dashboard.jsp"
   class="back">

Return to Dashboard

</a>


</div>


</body>

</html>