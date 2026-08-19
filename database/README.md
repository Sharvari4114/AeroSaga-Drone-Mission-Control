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
│   ├── README.md
│   └── V001__initial_schema.sql
├── seed/
│   ├── seed.sql
│   └── README.md
├── queries/
│   ├── queries.sql
│   ├── validation_queries.sql
│   └── README.md
└── README.md


## Backup and Restore

### Backup

Create a PostgreSQL database backup using `pg_dump`:

```bash
pg_dump -U postgres -d aerosaga -F c -f aerosaga_backup.dump