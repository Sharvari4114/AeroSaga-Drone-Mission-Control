# AeroSaga Database Views

This directory contains PostgreSQL views used to provide simplified access to commonly required AeroSaga data.

## Available Views

### mission_overview

Combines mission and drone information.

This view can be used by the backend to retrieve mission details together with the assigned drone information.

### mission_step_overview

Combines mission step information with mission details.

This view can be used to track the progress and execution status of mission steps.

### latest_drone_telemetry

Provides the most recent telemetry record for each drone.

This view can be used by the backend dashboard to display the latest drone location, altitude, speed, battery level, and telemetry timestamp.