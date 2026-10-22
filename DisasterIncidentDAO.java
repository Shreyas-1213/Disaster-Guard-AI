
package com.disaster.intelligence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.disaster.util.DBConnection;

public class DisasterIncidentDAO {

    public boolean addIncident(DisasterIncident incident)
            throws SQLException {

        String sql =
            "INSERT INTO disaster_incidents " +
            "(incident_type, location, severity, description, incident_status) " +
            "VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection()) {

            if (connection == null) {
                throw new SQLException(
                    "Database connection failed. Check DBConnection.java."
                );
            }

            try (PreparedStatement statement =
                    connection.prepareStatement(sql)) {

                statement.setString(1, incident.getIncidentType());
                statement.setString(2, incident.getLocation());
                statement.setString(3, incident.getSeverity());
                statement.setString(4, incident.getDescription());

                String status = incident.getIncidentStatus();

                if (status == null || status.trim().isEmpty()) {
                    status = "REPORTED";
                }

                statement.setString(5, status);

                return statement.executeUpdate() == 1;
            }
        }
    }

    public List<DisasterIncident> getAllIncidents()
            throws SQLException {

        List<DisasterIncident> incidents = new ArrayList<>();

        String sql =
            "SELECT incident_id, incident_type, location, severity, " +
            "description, incident_status, reported_at, updated_at " +
            "FROM disaster_incidents ORDER BY reported_at DESC";

        try (Connection connection = DBConnection.getConnection()) {

            if (connection == null) {
                throw new SQLException(
                    "Database connection failed. Check DBConnection.java."
                );
            }

            try (PreparedStatement statement =
                    connection.prepareStatement(sql);
                 ResultSet result = statement.executeQuery()) {

                while (result.next()) {

                    DisasterIncident incident = new DisasterIncident();

                    incident.setIncidentId(
                        result.getInt("incident_id")
                    );

                    incident.setIncidentType(
                        result.getString("incident_type")
                    );

                    incident.setLocation(
                        result.getString("location")
                    );

                    incident.setSeverity(
                        result.getString("severity")
                    );

                    incident.setDescription(
                        result.getString("description")
                    );

                    incident.setIncidentStatus(
                        result.getString("incident_status")
                    );

                    incident.setReportedAt(
                        result.getTimestamp("reported_at")
                    );

                    incident.setUpdatedAt(
                        result.getTimestamp("updated_at")
                    );

                    incidents.add(incident);
                }
            }
        }

        return incidents;
    }
}
