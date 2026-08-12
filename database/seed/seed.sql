-- AeroSaga Drone Mission Control
-- Sample / Seed Data
-- PostgreSQL

-- ============================================
-- 1. DRONES
-- ============================================

INSERT INTO drones
    (drone_code, status, battery_level, latitude, longitude, altitude)
VALUES
    ('DRN-001', 'IDLE', 95.00, 16.7050, 74.2433, 0.00),
    ('DRN-002', 'ACTIVE', 82.50, 16.7100, 74.2500, 120.00),
    ('DRN-003', 'ACTIVE', 68.00, 16.7200, 74.2600, 150.00),
    ('DRN-004', 'OFFLINE', 45.00, 16.7300, 74.2700, 100.00),
    ('DRN-005', 'MAINTENANCE', 100.00, 16.7400, 74.2800, 0.00);


-- ============================================
-- 2. MISSIONS
-- ============================================

INSERT INTO missions
    (drone_id, mission_name, status, start_time)
VALUES
    (
        (SELECT drone_id FROM drones WHERE drone_code = 'DRN-001'),
        'Package Delivery Mission 001',
        'PENDING',
        NULL
    ),
    (
        (SELECT drone_id FROM drones WHERE drone_code = 'DRN-002'),
        'Package Delivery Mission 002',
        'ACTIVE',
        CURRENT_TIMESTAMP
    ),
    (
        (SELECT drone_id FROM drones WHERE drone_code = 'DRN-003'),
        'Package Delivery Mission 003',
        'ACTIVE',
        CURRENT_TIMESTAMP
    ),
    (
        (SELECT drone_id FROM drones WHERE drone_code = 'DRN-004'),
        'Package Delivery Mission 004',
        'PAUSED',
        CURRENT_TIMESTAMP
    );


-- ============================================
-- 3. MISSION STEPS
-- ============================================

-- Mission 1
INSERT INTO mission_steps
    (mission_id, step_order, step_type, status)
VALUES
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 001'),
        1, 'TAKEOFF', 'PENDING'
    ),
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 001'),
        2, 'NAVIGATE', 'PENDING'
    ),
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 001'),
        3, 'DROP', 'PENDING'
    ),
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 001'),
        4, 'RETURN', 'PENDING'
    );

-- Mission 2
INSERT INTO mission_steps
    (mission_id, step_order, step_type, status)
VALUES
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 002'),
        1, 'TAKEOFF', 'COMPLETED'
    ),
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 002'),
        2, 'NAVIGATE', 'ACTIVE'
    ),
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 002'),
        3, 'DROP', 'PENDING'
    ),
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 002'),
        4, 'RETURN', 'PENDING'
    );

-- Mission 3
INSERT INTO mission_steps
    (mission_id, step_order, step_type, status)
VALUES
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 003'),
        1, 'TAKEOFF', 'COMPLETED'
    ),
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 003'),
        2, 'NAVIGATE', 'ACTIVE'
    ),
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 003'),
        3, 'DROP', 'PENDING'
    ),
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 003'),
        4, 'RETURN', 'PENDING'
    );


-- ============================================
-- 4. TELEMETRY
-- ============================================

INSERT INTO telemetry
    (drone_id, latitude, longitude, altitude, speed, battery_level)
VALUES
    (
        (SELECT drone_id FROM drones WHERE drone_code = 'DRN-002'),
        16.7100, 74.2500, 120.00, 35.50, 82.50
    ),
    (
        (SELECT drone_id FROM drones WHERE drone_code = 'DRN-002'),
        16.7120, 74.2520, 125.00, 36.20, 81.80
    ),
    (
        (SELECT drone_id FROM drones WHERE drone_code = 'DRN-003'),
        16.7200, 74.2600, 150.00, 40.00, 68.00
    ),
    (
        (SELECT drone_id FROM drones WHERE drone_code = 'DRN-003'),
        16.7230, 74.2630, 155.00, 39.50, 67.20
    ),
    (
        (SELECT drone_id FROM drones WHERE drone_code = 'DRN-004'),
        16.7300, 74.2700, 100.00, 0.00, 45.00
    );


-- ============================================
-- 5. WORKFLOW EXECUTIONS
-- ============================================

INSERT INTO workflow_executions
    (mission_id, temporal_workflow_id, temporal_run_id, status)
VALUES
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 002'),
        'aerosaga-mission-002',
        'run-002-demo',
        'RUNNING'
    ),
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 003'),
        'aerosaga-mission-003',
        'run-003-demo',
        'RUNNING'
    ),
    (
        (SELECT mission_id FROM missions
         WHERE mission_name = 'Package Delivery Mission 004'),
        'aerosaga-mission-004',
        'run-004-demo',
        'PAUSED'
    );