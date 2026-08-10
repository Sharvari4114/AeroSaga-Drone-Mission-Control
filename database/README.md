# AeroSaga Database & Data Layer

## Overview

This directory contains the database design, schema, migrations,
seed data, queries, and documentation for the AeroSaga autonomous
drone mission control system.

## Database Technology

- Database: PostgreSQL
- Database Management Tool: pgAdmin 4
- Migration Tool: Flyway
- Backend Integration: Spring Boot
- ORM: Spring Data JPA / Hibernate

## Database Responsibilities

The database layer is responsible for storing and managing:

- Operator information
- Drone information
- Mission information
- Mission steps
- Drone telemetry
- Workflow execution references

## Planned Database Entities

1. Operators
2. Drones
3. Missions
4. Mission Steps
5. Telemetry
6. Workflow Executions

## Directory Structure

```text
database/
├── schema/
├── migrations/
├── seed/
├── queries/
└── README.md