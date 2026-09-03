-- AeroSaga Backend-Database Integration Test
-- PostgreSQL

-- 1. Verify database tables
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;


-- 2. Verify drones can be read
SELECT drone_id, drone_code, status, battery_level
FROM drones
ORDER BY drone_id;


-- 3. Verify missions can be read with their drone
SELECT
    m.mission_id,
    m.mission_name,
    m.status,
    d.drone_code
FROM missions m
JOIN drones d
    ON m.drone_id = d.drone_id
ORDER BY m.mission_id;


-- 4. Verify mission steps
SELECT
    ms.step_id,
    ms.mission_id,
    ms.step_order,
    ms.step_type,
    ms.status
FROM mission_steps ms
ORDER BY ms.mission_id, ms.step_order;


-- 5. Verify latest telemetry for each drone
SELECT DISTINCT ON (drone_id)
    drone_id,
    latitude,
    longitude,
    altitude,
    speed,
    battery_level,
    recorded_at
FROM telemetry
ORDER BY drone_id, recorded_at DESC;


-- 6. Verify Temporal workflow references
SELECT
    workflow_execution_id,
    mission_id,
    temporal_workflow_id,
    temporal_run_id,
    status
FROM workflow_executions
ORDER BY workflow_execution_id;


-- 7. Verify mission overview view
SELECT *
FROM mission_overview;


-- 8. Verify mission step overview view
SELECT *
FROM mission_step_overview;


-- 9. Verify latest telemetry view
SELECT *
FROM latest_drone_telemetry;