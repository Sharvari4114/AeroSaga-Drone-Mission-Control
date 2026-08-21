# AeroSaga Database Backend Integration Guide

## Purpose

This document describes how the AeroSaga Spring Boot backend will interact
with the PostgreSQL database.

The database stores application-level drone, mission, telemetry, and workflow
reference data required by the backend.

Temporal.io remains responsible for durable workflow execution state.

---

## Database Information

- Database: PostgreSQL
- Database Name: `aerosaga`
- Administration Tool: pgAdmin 4

---

## Database Tables

### 1. Drones

Stores information about each drone.

Important data:

- Drone ID
- Drone code
- Status
- Battery level
- Current latitude
- Current longitude
- Altitude

Backend operations:

- Get all drones
- Get drone by ID
- Update drone status
- Update drone location and battery

---

### 2. Missions

Stores drone delivery mission information.

Backend operations:

- Create a mission
- Get mission details
- Get missions for a drone
- Update mission status

Relationship:

```text
One Drone → Many Missions
```

---

### 3. Mission Steps

Stores the individual steps of a drone mission.

Example:

```text
TAKEOFF
   ↓
NAVIGATE
   ↓
DROP
   ↓
RETURN
```

Backend operations:

- Get mission steps
- Update step status
- Record step start time
- Record step completion time

Relationship:

```text
One Mission → Many Mission Steps
```

---

### 4. Telemetry

Stores drone telemetry and GPS information.

Important data:

- Latitude
- Longitude
- Altitude
- Speed
- Battery level
- Recorded time

Backend operations:

- Store incoming telemetry
- Get latest telemetry for a drone
- Get telemetry history

Relationship:

```text
One Drone → Many Telemetry Records
```

---

### 5. Workflow Executions

Stores the reference between an AeroSaga mission and its Temporal workflow.

Important data:

- Mission ID
- Temporal workflow ID
- Temporal run ID
- Workflow status
- Start time
- Completion time

Backend operations:

- Create workflow execution reference
- Get workflow status
- Update workflow status

Relationship:

```text
One Mission → One Workflow Execution
```

---

## Important Backend Data Flow

```text
React / CesiumJS Dashboard
          │
          ↓
Spring Boot Backend
          │
          ├── PostgreSQL
          │     ├── Drones
          │     ├── Missions
          │     ├── Mission Steps
          │     ├── Telemetry
          │     └── Workflow Execution References
          │
          ↓
       Temporal.io
          │
          ↓
Durable Mission Workflow
```

---

## Spring Boot Integration Requirements

The backend will need:

- PostgreSQL JDBC driver
- Database connection configuration
- Entity models
- Repository or data access layer
- Database transaction handling
- Input validation

---

## Common Database Operations

The backend is expected to perform operations such as:

```text
GET    /drones
GET    /drones/{id}
GET    /drones/{id}/telemetry

GET    /missions
GET    /missions/{id}
GET    /missions/{id}/steps

POST   /missions

PATCH  /drones/{id}/status
PATCH  /missions/{id}/status
PATCH  /missions/{id}/steps
```

These operations will be finalized according to the actual Spring Boot backend API design.

---

## Integration Responsibility

The database layer is responsible for:

- Providing a reliable PostgreSQL schema
- Maintaining table relationships
- Enforcing database constraints
- Supporting efficient queries
- Providing migration and seed data
- Supporting backend data access requirements

The Spring Boot backend is responsible for connecting to the database and
using the database layer to store and retrieve AeroSaga application data.