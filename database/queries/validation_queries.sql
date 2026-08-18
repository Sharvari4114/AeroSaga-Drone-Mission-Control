-- AeroSaga Database Validation Queries
-- PostgreSQL


-- ============================================
-- 1. CHECK DRONES WITHOUT MISSIONS
-- ============================================

SELECT d.drone_id, d.drone_code
FROM drones d
LEFT JOIN missions m
    ON d.drone_id = m.drone_id
WHERE m.mission_id IS NULL;


-- ============================================
-- 2. CHECK MISSIONS WITHOUT VALID DRONES
-- ============================================

SELECT m.mission_id, m.mission_name
FROM missions m
LEFT JOIN drones d
    ON m.drone_id = d.drone_id
WHERE d.drone_id IS NULL;


-- ============================================
-- 3. CHECK MISSION STEPS WITHOUT MISSIONS
-- ============================================

SELECT ms.step_id, ms.mission_id
FROM mission_steps ms
LEFT JOIN missions m
    ON ms.mission_id = m.mission_id
WHERE m.mission_id IS NULL;


-- ============================================
-- 4. CHECK TELEMETRY WITHOUT VALID DRONES
-- ============================================

SELECT t.telemetry_id, t.drone_id
FROM telemetry t
LEFT JOIN drones d
    ON t.drone_id = d.drone_id
WHERE d.drone_id IS NULL;


-- ============================================
-- 5. CHECK WORKFLOWS WITHOUT VALID MISSIONS
-- ============================================

SELECT w.workflow_execution_id, w.mission_id
FROM workflow_executions w
LEFT JOIN missions m
    ON w.mission_id = m.mission_id
WHERE m.mission_id IS NULL;


-- ============================================
-- 6. CHECK DUPLICATE DRONE CODES
-- ============================================

SELECT drone_code, COUNT(*) AS duplicate_count
FROM drones
GROUP BY drone_code
HAVING COUNT(*) > 1;


-- ============================================
-- 7. CHECK INVALID BATTERY VALUES
-- ============================================

SELECT drone_id, drone_code, battery_level
FROM drones
WHERE battery_level < 0
   OR battery_level > 100;


-- ============================================
-- 8. CHECK INVALID TELEMETRY BATTERY VALUES
-- ============================================

SELECT telemetry_id, drone_id, battery_level
FROM telemetry
WHERE battery_level < 0
   OR battery_level > 100;


-- ============================================
-- 9. CHECK DUPLICATE MISSION STEP ORDER
-- ============================================

SELECT mission_id, step_order, COUNT(*) AS duplicate_count
FROM mission_steps
GROUP BY mission_id, step_order
HAVING COUNT(*) > 1;


-- ============================================
-- 10. CHECK CURRENT DATABASE RECORD COUNTS
-- ============================================

SELECT 'drones' AS table_name, COUNT(*) AS record_count
FROM drones

UNION ALL

SELECT 'missions', COUNT(*)
FROM missions

UNION ALL

SELECT 'mission_steps', COUNT(*)
FROM mission_steps

UNION ALL

SELECT 'telemetry', COUNT(*)
FROM telemetry

UNION ALL

SELECT 'workflow_executions', COUNT(*)
FROM workflow_executions;