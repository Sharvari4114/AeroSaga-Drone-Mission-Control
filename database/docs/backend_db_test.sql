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


--Invalid battery
INSERT INTO drones
(drone_code, battery_level)
VALUES ('TEST-INVALID', 150);

--Invalid drone status
INSERT INTO drones
(drone_code, status)
VALUES ('TEST-STATUS', 'FLYING');

--Invalid mission drone
INSERT INTO missions
(drone_id, mission_name)
VALUES (9999, 'Invalid Mission');

--Invalid mission status
INSERT INTO missions
(drone_id, mission_name, status)
VALUES (1, 'Invalid Status Mission', 'RUNNING');


--Invalid mission step order
INSERT INTO mission_steps
(mission_id, step_order, step_type)
VALUES (1, 0, 'TAKEOFF');

--Invalid step type
INSERT INTO mission_steps
(mission_id, step_order, step_type)
VALUES (1, 99, 'FLY');



----------------------------------------------------
--Testing relationships
--1.Drone → Mission
SELECT
    m.mission_id,
    m.mission_name,
    d.drone_code
FROM missions m
JOIN drones d
ON m.drone_id = d.drone_id;


--2.Mission → Mission Steps
SELECT
    m.mission_name,
    ms.step_order,
    ms.step_type
FROM missions m
JOIN mission_steps ms
ON m.mission_id = ms.mission_id
ORDER BY m.mission_id, ms.step_order;


--3.Drone → Telemetry
SELECT
    d.drone_code,
    t.latitude,
    t.longitude,
    t.speed,
    t.recorded_at
FROM drones d
JOIN telemetry t
ON d.drone_id = t.drone_id;


--4.Mission → Temporal Workflow
SELECT
    m.mission_name,
    w.temporal_workflow_id,
    w.temporal_run_id,
    w.status
FROM missions m
JOIN workflow_executions w
ON m.mission_id = w.mission_id;



------------------------------------------------------------
----Verifying indexes
SELECT indexname, tablename
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;


----------------------------------------------------------------
---Verify all five tables have data

SELECT 'drones' AS table_name, COUNT(*) AS record_count FROM drones
UNION ALL
SELECT 'missions', COUNT(*) FROM missions
UNION ALL
SELECT 'mission_steps', COUNT(*) FROM mission_steps
UNION ALL
SELECT 'telemetry', COUNT(*) FROM telemetry
UNION ALL
SELECT 'workflow_executions', COUNT(*) FROM workflow_executions;