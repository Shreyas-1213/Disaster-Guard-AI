package com.disaster.model;

public class FailureChain {

    private String primaryHazard;
    private String secondaryHazard;
    private String infrastructureImpact;
    private String emergencyImpact;
    private int severity;

    public FailureChain(
            String primaryHazard,
            String secondaryHazard,
            String infrastructureImpact,
            String emergencyImpact,
            int severity) {

        this.primaryHazard = primaryHazard;
        this.secondaryHazard = secondaryHazard;
        this.infrastructureImpact = infrastructureImpact;
        this.emergencyImpact = emergencyImpact;
        this.severity = severity;
    }

    public String getPrimaryHazard() {
        return primaryHazard;
    }

    public String getSecondaryHazard() {
        return secondaryHazard;
    }

    public String getInfrastructureImpact() {
        return infrastructureImpact;
    }

    public String getEmergencyImpact() {
        return emergencyImpact;
    }

    public int getSeverity() {
        return severity;
    }
}