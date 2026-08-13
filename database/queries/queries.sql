-- AeroSaga Drone Mission Control
-- Common Database Queries
-- PostgreSQL


-- ============================================
-- 1. GET ALL DRONES
-- ============================================

SELECT *
FROM drones
ORDER BY drone_id;


-- ============================================
-- 2. GET ACTIVE DRONES
-- ============================================

SELECT *
FROM drones
WHERE status = 'ACTIVE'
ORDER BY drone_id;


-- ============================================
-- 3. GET DRONE BY CODE
-- ============================================

SELECT *
FROM drones
WHERE drone_code = 'DRN-002';


-- ============================================
-- 4. GET ALL MISSIONS OF A DRONE
-- ============================================

SELECT
    m.mission_id,
    m.mission_name,
    m.status,
    m.start_time,
    m.end_time
FROM missions m
JOIN drones d
    ON m.drone_id = d.drone_id
WHERE d.drone_code = 'DRN-002'
ORDER BY m.created_at DESC;


-- ============================================
-- 5. GET ACTIVE MISSIONS
-- ============================================

SELECT
    m.mission_id,
    m.mission_name,
    d.drone_code,
    m.status,
    m.start_time
FROM missions m
JOIN drones d
    ON m.drone_id = d.drone_id
WHERE m.status = 'ACTIVE'
ORDER BY m.start_time DESC;


-- ============================================
-- 6. GET MISSION STEPS
-- ============================================

SELECT
    ms.step_order,
    ms.step_type,
    ms.status,
    ms.started_at,
    ms.completed_at
FROM mission_steps ms
JOIN missions m
    ON ms.mission_id = m.mission_id
WHERE m.mission_id = 2
ORDER BY ms.step_order;


-- ============================================
-- 7. GET LATEST TELEMETRY OF A DRONE
-- ============================================

SELECT
    t.telemetry_id,
    d.drone_code,
    t.latitude,
    t.longitude,
    t.altitude,
    t.speed,
    t.battery_level,
    t.recorded_at
FROM telemetry t
JOIN drones d
    ON t.drone_id = d.drone_id
WHERE d.drone_code = 'DRN-002'
ORDER BY t.recorded_at DESC
LIMIT 1;


-- ============================================
-- 8. GET WORKFLOW STATUS OF A MISSION
-- ============================================

SELECT
    m.mission_id,
    m.mission_name,
    d.drone_code,
    w.temporal_workflow_id,
    w.temporal_run_id,
    w.status AS workflow_status,
    w.started_at,
    w.completed_at
FROM workflow_executions w
JOIN missions m
    ON w.mission_id = m.mission_id
JOIN drones d
    ON m.drone_id = d.drone_id
WHERE m.mission_id = 2;


-- ============================================
-- 9. GET OFFLINE DRONES
-- ============================================

SELECT
    drone_id,
    drone_code,
    battery_level,
    latitude,
    longitude,
    updated_at
FROM drones
WHERE status = 'OFFLINE'
ORDER BY updated_at DESC;


-- ============================================
-- 10. GET LOW-BATTERY DRONES
-- ============================================

SELECT
    drone_id,
    drone_code,
    status,
    battery_level
FROM drones
WHERE battery_level < 30
ORDER BY battery_level ASC;