# AeroSaga Query Performance Analysis

## Purpose

This document analyzes important PostgreSQL queries used by the AeroSaga
Drone Mission Control system.

The queries are tested using `EXPLAIN ANALYZE` to understand how PostgreSQL
executes them and to verify that the database indexes support efficient
data retrieval.

---

## 1. Latest Telemetry for a Drone

### Query

```sql
EXPLAIN ANALYZE
SELECT *
FROM telemetry
WHERE drone_id = 1
ORDER BY recorded_at DESC
LIMIT 1;
```

### Purpose

This query retrieves the most recent GPS and telemetry information for a
specific drone.

### Related Index

```text
idx_telemetry_drone_recorded
(drone_id, recorded_at DESC)
```

---

## 2. Missions for a Drone

### Query

```sql
EXPLAIN ANALYZE
SELECT *
FROM missions
WHERE drone_id = 1;
```

### Purpose

This query retrieves all missions assigned to a specific drone.

### Related Index

```text
idx_missions_drone_id
(drone_id)
```

---

## 3. Mission Steps

### Query

```sql
EXPLAIN ANALYZE
SELECT *
FROM mission_steps
WHERE mission_id = 1
ORDER BY step_order;
```

### Purpose

This query retrieves all steps of a specific drone mission in execution order.

### Related Index

```text
idx_mission_steps_mission_id
(mission_id)
```

---

## 4. Workflow Status

### Query

```sql
EXPLAIN ANALYZE
SELECT *
FROM workflow_executions
WHERE status = 'RUNNING';
```

### Purpose

This query retrieves currently running Temporal workflow execution records.

### Related Index

```text
idx_workflow_status
(status)
```

---

## Conclusion

The AeroSaga database includes indexes on frequently queried columns to
support efficient retrieval of mission, telemetry, mission-step, and
workflow execution data.

`EXPLAIN ANALYZE` is used to inspect the PostgreSQL execution plan and
measure the actual execution of important database queries.




## Test Results

The following queries were tested using `EXPLAIN ANALYZE` in PostgreSQL.

| Query | Index Used | Result |
|---|---|---|
| Latest telemetry for a drone | `idx_telemetry_drone_recorded` | Index Scan |
| Missions for a drone | `idx_missions_drone_id` | Index Scan |
| Mission steps for a mission | `idx_mission_steps_mission_id` | Bitmap Index Scan |
| Running workflow executions | `idx_workflow_status` | Index Scan |

The test results confirm that PostgreSQL uses the defined indexes for the important AeroSaga data retrieval operations.

### Observations

- Mission queries efficiently use the `drone_id` index.
- Mission-step queries use the `mission_id` index and then sort results by `step_order`.
- Workflow status queries use the `status` index.
- Telemetry queries use the composite `(drone_id, recorded_at DESC)` index, which is suitable for retrieving recent drone telemetry.