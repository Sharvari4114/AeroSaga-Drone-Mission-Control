-- ============================================
-- AeroSaga Database Views
-- ============================================


-- ============================================
-- 1. MISSION OVERVIEW
-- ============================================

CREATE OR REPLACE VIEW mission_overview AS
SELECT
    m.mission_id,
    m.mission_name,
    m.status AS mission_status,
    m.start_time,
    m.end_time,
    d.drone_id,
    d.drone_code,
    d.status AS drone_status,
    d.battery_level
FROM missions m
JOIN drones d
    ON m.drone_id = d.drone_id;


-- ============================================
-- 2. MISSION STEP OVERVIEW
-- ============================================

CREATE OR REPLACE VIEW mission_step_overview AS
SELECT
    ms.step_id,
    ms.step_order,
    ms.step_type,
    ms.status AS step_status,
    ms.started_at,
    ms.completed_at,
    m.mission_id,
    m.mission_name,
    m.status AS mission_status
FROM mission_steps ms
JOIN missions m
    ON ms.mission_id = m.mission_id;


-- ============================================
-- 3. LATEST DRONE TELEMETRY
-- ============================================

CREATE OR REPLACE VIEW latest_drone_telemetry AS
SELECT DISTINCT ON (d.drone_id)
    d.drone_id,
    d.drone_code,
    t.latitude,
    t.longitude,
    t.altitude,
    t.speed,
    t.battery_level,
    t.recorded_at
FROM drones d
LEFT JOIN telemetry t
    ON d.drone_id = t.drone_id
ORDER BY d.drone_id, t.recorded_at DESC;