
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Emergency Support | DisasterGuard AI</title>

<style>
* { box-sizing: border-box; }

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #0b1220;
    color: #e5e7eb;
}

header {
    background: #111c30;
    padding: 22px 7%;
    border-bottom: 1px solid #26364e;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    flex-wrap: wrap;
}

header h1 {
    margin: 0;
    color: #60a5fa;
    font-size: 25px;
}

header a {
    color: white;
    text-decoration: none;
    background: #2563eb;
    padding: 10px 16px;
    border-radius: 8px;
}

.container {
    max-width: 1100px;
    margin: 30px auto;
    padding: 0 20px;
}

.intro {
    background: #17243a;
    border: 1px solid #30415d;
    border-radius: 14px;
    padding: 24px;
    margin-bottom: 24px;
}

.intro h2 { margin-top: 0; color: #93c5fd; }

.warning {
    background: #451a1a;
    border: 1px solid #b91c1c;
    padding: 16px;
    border-radius: 10px;
    line-height: 1.6;
}

.grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 20px;
    margin-top: 24px;
}

.card {
    background: #17243a;
    border: 1px solid #30415d;
    padding: 22px;
    border-radius: 14px;
}

.card h3 { color: #93c5fd; margin-top: 0; }

.card p, li { line-height: 1.7; }

.btn {
    display: inline-block;
    margin-top: 10px;
    padding: 11px 14px;
    border-radius: 8px;
    background: #2563eb;
    color: white;
    text-decoration: none;
    font-weight: bold;
}

.btn:hover { background: #1d4ed8; }

.emergency-number {
    font-size: 30px;
    font-weight: bold;
    color: #fca5a5;
}

footer {
    text-align: center;
    padding: 25px;
    color: #94a3b8;
}

@media (max-width: 600px) {
    header { padding: 18px 5%; }
    .container { padding: 0 14px; }
}
</style>
</head>

<body>
<header>
    <h1>🛡 DisasterGuard AI</h1>
    <a href="<%=request.getContextPath()%>/dashboard.jsp">← Back to Dashboard</a>
</header>

<main class="container">
    <section class="intro">
        <h2>Emergency Support Center</h2>
        <p>Find emergency contacts, search for nearby help, and review basic disaster safety instructions.</p>

        <div class="warning">
            <strong>⚠ Immediate danger?</strong><br>
            If you are in India, call <strong>112</strong> for emergency assistance.
            Move to a safer location if possible and follow instructions from local authorities.
            This page does not automatically contact emergency services.
        </div>
    </section>

    <h2>Emergency Contacts — India</h2>

    <div class="grid">
        <section class="card">
            <h3>🚨 General Emergency</h3>
            <div class="emergency-number">112</div>
            <p>Pan-India emergency response number.</p>
            <a class="btn" href="tel:112">Call 112</a>
        </section>

        <section class="card">
            <h3>🚒 Fire Services</h3>
            <div class="emergency-number">101</div>
            <p>Fire and rescue assistance. Availability and routing may vary.</p>
            <a class="btn" href="tel:101">Call 101</a>
        </section>

        <section class="card">
            <h3>🚑 Ambulance</h3>
            <div class="emergency-number">108</div>
            <p>Ambulance emergency service in areas where the service operates.</p>
            <a class="btn" href="tel:108">Call 108</a>
        </section>
    </div>

    <h2 style="margin-top:35px;">Find Nearby Help</h2>

    <div class="grid">
        <section class="card">
            <h3>🏥 Nearby Hospitals</h3>
            <p>Search for hospitals near your current location using Google Maps.</p>
            <a class="btn"
               href="https://www.google.com/maps/search/hospitals+near+me"
               target="_blank" rel="noopener noreferrer">
               Find Hospitals
            </a>
        </section>

        <section class="card">
            <h3>🏠 Emergency Shelters</h3>
            <p>Search for shelters and relief centres. Confirm availability with local authorities.</p>
            <a class="btn"
               href="https://www.google.com/maps/search/emergency+shelters+near+me"
               target="_blank" rel="noopener noreferrer">
               Find Shelters
            </a>
        </section>

        <section class="card">
            <h3>📍 Safe Places Nearby</h3>
            <p>Look for open, accessible places and check official local evacuation guidance.</p>
            <a class="btn"
               href="https://www.google.com/maps/search/safe+places+near+me"
               target="_blank" rel="noopener noreferrer">
               Open Map Search
            </a>
        </section>
    </div>

    <h2 style="margin-top:35px;">Disaster Safety Guide</h2>

    <div class="grid">
        <section class="card">
            <h3>🌊 Flood Safety</h3>
            <ul>
                <li>Move to higher ground when instructed or when flooding threatens.</li>
                <li>Never walk or drive through floodwater.</li>
                <li>Stay away from fallen power lines.</li>
                <li>Follow official evacuation instructions.</li>
            </ul>
        </section>

        <section class="card">
            <h3>🌍 Earthquake Safety</h3>
            <ul>
                <li>Drop, cover, and hold on during shaking.</li>
                <li>Stay away from windows and heavy objects.</li>
                <li>If outdoors, move away from buildings and power lines.</li>
                <li>Expect aftershocks and follow official guidance.</li>
            </ul>
        </section>

        <section class="card">
            <h3>⛈ Storm Safety</h3>
            <ul>
                <li>Stay indoors and away from windows.</li>
                <li>Avoid flooded roads and exposed areas.</li>
                <li>Charge your phone and keep a torch ready.</li>
                <li>Follow weather alerts from official authorities.</li>
            </ul>
        </section>

        <section class="card">
            <h3>🎒 Emergency Kit</h3>
            <ul>
                <li>Drinking water and packaged food.</li>
                <li>First-aid supplies and essential medicines.</li>
                <li>Torch, batteries, and power bank.</li>
                <li>Identification documents and emergency contacts.</li>
            </ul>
        </section>
    </div>
</main>

<footer>
    DisasterGuard AI | Emergency preparedness and safety information
</footer>
</body>
</html>
```