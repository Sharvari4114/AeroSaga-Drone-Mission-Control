# AeroSaga Database Test Plan

## 1. Purpose

This document defines the tests required to verify that the AeroSaga
PostgreSQL database is working correctly and is ready for backend integration.

## 2. Database

- Database: PostgreSQL
- Database Name: aerosaga
- Administration Tool: pgAdmin 4

## 3. Tables Under Test

1. drones
2. missions
3. mission_steps
4. telemetry
5. workflow_executions

## 4. Relationship Tests

### Drone and Mission
Verify that every mission references a valid drone.

### Mission and Mission Steps
Verify that every mission step references a valid mission.

### Drone and Telemetry
Verify that telemetry records reference valid drones.

### Mission and Workflow Execution
Verify that workflow execution records reference valid missions.

## 5. Data Validation Tests

- Verify primary keys are unique.
- Verify foreign key relationships.
- Verify drone battery level is between 0 and 100.
- Verify valid status values are accepted.
- Verify invalid status values are rejected.
- Verify mission step order is positive.
- Verify duplicate mission step orders are rejected.

## 6. Query Tests

Test the queries for:

- Finding missions for a drone.
- Finding mission steps for a mission.
- Finding telemetry for a drone.
- Finding workflow executions by status.
- Retrieving mission overview.
- Retrieving mission step overview.
- Retrieving latest drone telemetry.

## 7. Performance Tests

Use EXPLAIN ANALYZE to verify query execution plans and index usage.

Important indexes:

- idx_missions_drone_id
- idx_missions_status
- idx_mission_steps_mission_id
- idx_telemetry_drone_recorded
- idx_workflow_status

## 8. Expected Result

All valid records and relationships should work correctly, invalid data
should be rejected by database constraints, required queries should return
the expected results, and indexes should be used for appropriate queries.

## 9. Backend Integration

The backend should use the database tables and views according to the
database schema and integration documentation.

## 10. Final Verification

Before final project review:

- Schema verified
- Seed data verified
- Queries verified
- Validation queries verified
- Indexes verified
- Views verified
- Backend integration verified