# AeroSaga Database

PostgreSQL database layer for the AeroSaga Drone Mission Control system.

## Purpose

The database stores application-level information required by the
AeroSaga system, including drones, missions, mission steps, telemetry,
and Temporal workflow execution references.

Temporal.io remains responsible for durable workflow execution state.

## Database Technology

- Database: PostgreSQL
- Database Name: aerosaga
- Database Administration Tool: pgAdmin 4

## Directory Structure

```text
database/
├── schema/
│   ├── schema.sql
│   ├── ER-diagram.md
│   └── README.md
├── migrations/
│   └── README.md
├── seed/
│   ├── seed.sql
│   └── README.md
├── queries/
│   ├── queries.sql
│   └── README.md
└── README.md