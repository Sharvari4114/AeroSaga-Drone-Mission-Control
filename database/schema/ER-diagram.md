# AeroSaga Database ER Diagram

## Entities

### DRONES
- drone_id (PK)
- drone_code (Unique)
- status
- battery_level
- latitude
- longitude
- altitude
- created_at
- updated_at

### MISSIONS
- mission_id (PK)
- drone_id (FK → drones.drone_id)
- mission_name
- status
- start_time
- end_time
- created_at

### MISSION_STEPS
- step_id (PK)
- mission_id (FK → missions.mission_id)
- step_order
- step_type
- status
- started_at
- completed_at

### TELEMETRY
- telemetry_id (PK)
- drone_id (FK → drones.drone_id)
- latitude
- longitude
- altitude
- speed
- battery_level
- recorded_at

### WORKFLOW_EXECUTIONS
- workflow_execution_id (PK)
- mission_id (FK → missions.mission_id)
- temporal_workflow_id
- temporal_run_id
- status
- started_at
- completed_at

## Relationships

- One drone can have many missions.
- One mission belongs to one drone.
- One mission can have many mission steps.
- One mission step belongs to one mission.
- One drone can have many telemetry records.
- One telemetry record belongs to one drone.
- One mission has one Temporal workflow execution.
- One workflow execution belongs to one mission.

## Architecture Note

Temporal.io manages the durable execution state of workflows.
The database stores application-level drone, mission, mission-step,
telemetry, and workflow execution reference data.