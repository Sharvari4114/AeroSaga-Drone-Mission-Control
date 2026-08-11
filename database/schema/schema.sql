-- AeroSaga Drone Mission Control
-- Database Schema
-- PostgreSQL

-- ============================================
-- 1. DRONES
-- ============================================

CREATE TABLE drones (
    drone_id BIGSERIAL PRIMARY KEY,
    drone_code VARCHAR(50) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'IDLE',
    battery_level NUMERIC(5,2) NOT NULL DEFAULT 100.00,
    latitude NUMERIC(10,7),
    longitude NUMERIC(10,7),
    altitude NUMERIC(10,2),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_drone_status
        CHECK (status IN ('IDLE', 'ACTIVE', 'OFFLINE', 'RETURNING', 'MAINTENANCE')),

    CONSTRAINT chk_drone_battery
        CHECK (battery_level >= 0 AND battery_level <= 100)
);


-- ============================================
-- 2. MISSIONS
-- ============================================

CREATE TABLE missions (
    mission_id BIGSERIAL PRIMARY KEY,
    drone_id BIGINT NOT NULL,
    mission_name VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    start_time TIMESTAMPTZ,
    end_time TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_mission_drone
        FOREIGN KEY (drone_id)
        REFERENCES drones(drone_id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_mission_status
        CHECK (status IN (
            'PENDING',
            'ACTIVE',
            'PAUSED',
            'COMPLETED',
            'FAILED',
            'ABORTED'
        ))
);


-- ============================================
-- 3. MISSION STEPS
-- ============================================

CREATE TABLE mission_steps (
    step_id BIGSERIAL PRIMARY KEY,
    mission_id BIGINT NOT NULL,
    step_order INTEGER NOT NULL,
    step_type VARCHAR(30) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    started_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,

    CONSTRAINT fk_step_mission
        FOREIGN KEY (mission_id)
        REFERENCES missions(mission_id)
        ON DELETE CASCADE,

    CONSTRAINT uq_mission_step_order
        UNIQUE (mission_id, step_order),

    CONSTRAINT chk_step_order
        CHECK (step_order > 0),

    CONSTRAINT chk_step_type
        CHECK (step_type IN (
            'TAKEOFF',
            'NAVIGATE',
            'DROP',
            'RETURN'
        )),

    CONSTRAINT chk_step_status
        CHECK (status IN (
            'PENDING',
            'ACTIVE',
            'COMPLETED',
            'FAILED',
            'SKIPPED'
        ))
);


-- ============================================
-- 4. TELEMETRY
-- ============================================

CREATE TABLE telemetry (
    telemetry_id BIGSERIAL PRIMARY KEY,
    drone_id BIGINT NOT NULL,
    latitude NUMERIC(10,7) NOT NULL,
    longitude NUMERIC(10,7) NOT NULL,
    altitude NUMERIC(10,2),
    speed NUMERIC(10,2),
    battery_level NUMERIC(5,2),
    recorded_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_telemetry_drone
        FOREIGN KEY (drone_id)
        REFERENCES drones(drone_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_telemetry_battery
        CHECK (
            battery_level IS NULL
            OR (battery_level >= 0 AND battery_level <= 100)
        )
);


-- ============================================
-- 5. WORKFLOW EXECUTIONS
-- ============================================

CREATE TABLE workflow_executions (
    workflow_execution_id BIGSERIAL PRIMARY KEY,
    mission_id BIGINT NOT NULL UNIQUE,
    temporal_workflow_id VARCHAR(255) NOT NULL UNIQUE,
    temporal_run_id VARCHAR(255),
    status VARCHAR(30) NOT NULL DEFAULT 'RUNNING',
    started_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMPTZ,

    CONSTRAINT fk_workflow_mission
        FOREIGN KEY (mission_id)
        REFERENCES missions(mission_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_workflow_status
        CHECK (status IN (
            'RUNNING',
            'PAUSED',
            'COMPLETED',
            'FAILED',
            'CANCELLED'
        ))
);


-- ============================================
-- INDEXES
-- ============================================

CREATE INDEX idx_missions_drone_id
    ON missions(drone_id);

CREATE INDEX idx_missions_status
    ON missions(status);

CREATE INDEX idx_mission_steps_mission_id
    ON mission_steps(mission_id);

CREATE INDEX idx_telemetry_drone_recorded
    ON telemetry(drone_id, recorded_at DESC);

CREATE INDEX idx_workflow_status
    ON workflow_executions(status);