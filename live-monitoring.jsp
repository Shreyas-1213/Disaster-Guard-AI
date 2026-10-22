
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.disaster.intelligence.DisasterIncident" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<DisasterIncident> incidents =
        (List<DisasterIncident>) request.getAttribute("incidents");

    String success = request.getParameter("success");
    String error = request.getParameter("error");

    DateTimeFormatter formatter =
        DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Live Monitoring | DisasterGuard AI</title>

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
    background: #f1f5f9;
    color: #172033;
}

.navbar {
    background: #0f172a;
    color: white;
    padding: 18px 6%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    flex-wrap: wrap;
}

.logo {
    font-size: 23px;
    font-weight: bold;
}

.logo span {
    color: #38bdf8;
}

.nav-links {
    display: flex;
    gap: 18px;
}

.nav-links a {
    color: white;
    text-decoration: none;
    font-weight: bold;
}

.container {
    max-width: 1200px;
    margin: auto;
    padding: 32px 22px;
}

.heading h1 {
    margin-bottom: 8px;
    font-size: 30px;
}

.heading p {
    color: #64748b;
    line-height: 1.6;
}

.summary {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 18px;
    margin: 25px 0;
}

.summary-card {
    background: white;
    padding: 20px;
    border-radius: 12px;
    border: 1px solid #e2e8f0;
}

.summary-card span {
    color: #64748b;
    font-size: 14px;
}

.summary-card strong {
    display: block;
    font-size: 28px;
    margin-top: 10px;
}

.panel {
    background: white;
    padding: 24px;
    border-radius: 14px;
    margin-top: 24px;
    border: 1px solid #e2e8f0;
    box-shadow: 0 4px 14px rgba(15, 23, 42, 0.04);
}

.panel h2 {
    margin-top: 0;
    font-size: 21px;
}

.form-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 18px;
}

.field {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.field.full {
    grid-column: 1 / -1;
}

label {
    font-weight: bold;
    font-size: 14px;
}

input, select, textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #cbd5e1;
    border-radius: 8px;
    font: inherit;
    background: white;
}

textarea {
    min-height: 95px;
    resize: vertical;
}

.button {
    display: inline-block;
    padding: 12px 17px;
    border: none;
    border-radius: 8px;
    background: #0369a1;
    color: white;
    text-decoration: none;
    font-weight: bold;
    cursor: pointer;
    font-size: 14px;
}

.button:hover {
    background: #075985;
}

.button.secondary {
    background: #334155;
}

.message {
    padding: 14px 16px;
    border-radius: 8px;
    margin-top: 18px;
    line-height: 1.5;
}

.success {
    background: #dcfce7;
    color: #166534;
}

.error {
    background: #fee2e2;
    color: #991b1b;
}

.table-wrap {
    overflow-x: auto;
}

table {
    border-collapse: collapse;
    width: 100%;
    min-width: 760px;
}

th, td {
    padding: 13px 12px;
    border-bottom: 1px solid #e2e8f0;
    text-align: left;
    vertical-align: top;
    font-size: 14px;
}

th {
    background: #f8fafc;
    color: #475569;
}

.pill {
    display: inline-block;
    border-radius: 20px;
    padding: 6px 9px;
    font-size: 11px;
    font-weight: bold;
    white-space: nowrap;
}

.low {
    background: #dcfce7;
    color: #166534;
}

.medium {
    background: #fef3c7;
    color: #92400e;
}

.high {
    background: #ffedd5;
    color: #9a3412;
}

.critical {
    background: #fee2e2;
    color: #991b1b;
}

.status {
    background: #e0f2fe;
    color: #075985;
}

.muted {
    color: #64748b;
    font-size: 13px;
    line-height: 1.5;
}

.empty {
    text-align: center;
    padding: 30px 12px;
    color: #64748b;
}

.footer {
    text-align: center;
    padding: 25px;
    color: #64748b;
    font-size: 13px;
}

@media (max-width: 700px) {
    .summary {
        grid-template-columns: 1fr;
    }

    .form-grid {
        grid-template-columns: 1fr;
    }

    .field.full {
        grid-column: auto;
    }

    .container {
        padding: 25px 15px;
    }
}
</style>
</head>

<body>

<div class="navbar">
    <div class="logo">DisasterGuard <span>AI</span></div>

    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/dashboard.jsp">
            Dashboard
        </a>
        <a href="<%= request.getContextPath() %>/logout.jsp">
            Logout
        </a>
    </div>
</div>

<main class="container">

    <div class="heading">
        <h1>Disaster Incident Command Centre</h1>
        <p>
            Report incidents, track their severity, and review
            previously recorded disaster events.
        </p>
    </div>

    <% if ("created".equals(success)) { %>
        <div class="message success">
            Incident saved successfully to the database.
        </div>
    <% } %>

    <% if (error != null) { %>
        <div class="message error">
            <% if ("missing".equals(error)) { %>
                Please enter the incident type, location, and severity.
            <% } else if ("severity".equals(error)) { %>
                Invalid severity selected. Please try again.
            <% } else if ("database".equals(error)) { %>
                The incident could not be saved. Check your database
                connection and Tomcat console.
            <% } else { %>
                Unable to save the incident. Please try again.
            <% } %>
        </div>
    <% } %>

    <div class="summary">
        <div class="summary-card">
            <span>Total recorded incidents</span>
            <strong><%= incidents == null ? 0 : incidents.size() %></strong>
        </div>

        <div class="summary-card">
            <span>Unresolved incidents</span>
            <strong>
                <%
                    int activeCount = 0;

                    if (incidents != null) {
                        for (DisasterIncident item : incidents) {
                            if (!"RESOLVED".equals(item.getIncidentStatus())) {
                                activeCount++;
                            }
                        }
                    }
                %>
                <%= activeCount %>
            </strong>
        </div>

        <div class="summary-card">
            <span>Critical incidents</span>
            <strong>
                <%
                    int criticalCount = 0;

                    if (incidents != null) {
                        for (DisasterIncident item : incidents) {
                            if ("CRITICAL".equals(item.getSeverity())) {
                                criticalCount++;
                            }
                        }
                    }
                %>
                <%= criticalCount %>
            </strong>
        </div>
    </div>

    <section class="panel">
        <h2>＋ Report a Disaster Incident</h2>
        <p class="muted">
            Submit an incident report. The record will be stored in
            your disaster_management MySQL database.
        </p>

        <form method="post"
              action="<%= request.getContextPath() %>/DisasterIncidentServlet">

            <div class="form-grid">

                <div class="field">
                    <label for="incidentType">Disaster Type *</label>
                    <select id="incidentType" name="incidentType" required>
                        <option value="">Select disaster type</option>
                        <option value="Flood">Flood</option>
                        <option value="Earthquake">Earthquake</option>
                        <option value="Fire">Fire</option>
                        <option value="Storm">Storm</option>
                        <option value="Landslide">Landslide</option>
                        <option value="Road Accident">Road Accident</option>
                        <option value="Cyclone">Cyclone</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="field">
                    <label for="location">Incident Location *</label>
                    <input type="text"
                           id="location"
                           name="location"
                           maxlength="255"
                           placeholder="Enter area, city or address"
                           required>
                </div>

                <div class="field">
                    <label for="severity">Severity *</label>
                    <select id="severity" name="severity" required>
                        <option value="">Select severity</option>
                        <option value="LOW">Low</option>
                        <option value="MEDIUM">Medium</option>
                        <option value="HIGH">High</option>
                        <option value="CRITICAL">Critical</option>
                    </select>
                </div>

                <div class="field full">
                    <label for="description">Incident Description</label>
                    <textarea id="description"
                              name="description"
                              maxlength="5000"
                              placeholder="Describe the incident and any known impact"></textarea>
                </div>

                <div class="field full">
                    <button type="submit" class="button">
                        Save Incident
                    </button>
                </div>

            </div>
        </form>
    </section>

    <section class="panel">
        <h2>Incident History</h2>
        <p class="muted">
            Records are retrieved from MySQL and ordered by report time.
            These are submitted incident reports, not independently
            verified live disaster alerts.
        </p>

        <% if (incidents == null || incidents.isEmpty()) { %>

            <div class="empty">
                <h3>No incidents recorded yet</h3>
                <p>Submit your first incident using the form above.</p>
            </div>

        <% } else { %>

            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Disaster</th>
                            <th>Location</th>
                            <th>Severity</th>
                            <th>Status</th>
                            <th>Description</th>
                            <th>Reported At</th>
                        </tr>
                    </thead>

                    <tbody>
                    <% for (DisasterIncident item : incidents) { %>
                        <tr>
                            <td><%= item.getIncidentId() %></td>
                            <td><%= escapeHtml(item.getIncidentType()) %></td>
                            <td><%= escapeHtml(item.getLocation()) %></td>

                            <td>
                                <span class="pill <%= item.getSeverity().toLowerCase() %>">
                                    <%= escapeHtml(item.getSeverity()) %>
                                </span>
                            </td>

                            <td>
                                <span class="pill status">
                                    <%= escapeHtml(item.getIncidentStatus()) %>
                                </span>
                            </td>

                            <td>
                                <%= escapeHtml(item.getDescription() == null
                                        || item.getDescription().isEmpty()
                                        ? "—" : item.getDescription()) %>
                            </td>

                            <td>
                                <%
                                    if (item.getReportedAt() != null) {
                                        out.print(item.getReportedAt()
                                            .toLocalDateTime()
                                            .format(formatter));
                                    } else {
                                        out.print("—");
                                    }
                                %>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

        <% } %>

        <div style="margin-top:20px;">
            <a class="button secondary"
               href="<%= request.getContextPath() %>/DisasterIncidentServlet">
                Refresh Incident Records
            </a>

            <a class="button secondary"
               href="<%= request.getContextPath() %>/dashboard.jsp">
                Back to Dashboard
            </a>
        </div>
    </section>

</main>

<div class="footer">
    DisasterGuard AI | Incident Management
</div>

<%!
    private String escapeHtml(String value) {
        if (value == null) {
            return "";
        }

        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#x27;");
    }
%>

</body>
</html>
