-- +goose Up
-- +goose StatementBegin
-- modify builds for migrations
ALTER TABLE builds ADD IF NOT EXISTS migrated_from BIGINT;
CREATE INDEX IF NOT EXISTS builds_repo_name_idx ON builds (repo_name);
CREATE INDEX IF NOT EXISTS builds_repo_owner_idx ON builds (repo_owner DESC);
CREATE INDEX IF NOT EXISTS builds_repo_source_idx ON builds (repo_source);
-- modify build_logs for migrations
ALTER TABLE build_logs ADD IF NOT EXISTS migrated_from BIGINT;
CREATE INDEX IF NOT EXISTS build_logs_repo_name_idx ON build_logs (repo_name);
CREATE INDEX IF NOT EXISTS build_logs_repo_owner_idx ON build_logs (repo_owner DESC);
CREATE INDEX IF NOT EXISTS build_logs_repo_source_idx ON build_logs (repo_source);
-- modify build_versions for migrations
ALTER TABLE build_versions ADD IF NOT EXISTS migrated_from BIGINT;
-- modify releases for migrations
ALTER TABLE releases ADD IF NOT EXISTS migrated_from BIGINT;
CREATE INDEX IF NOT EXISTS releases_repo_name_idx ON releases (repo_name);
CREATE INDEX IF NOT EXISTS releases_repo_owner_idx ON releases (repo_owner DESC);
CREATE INDEX IF NOT EXISTS releases_repo_source_idx ON releases (repo_source);
-- modify release_logs for migrations
ALTER TABLE release_logs ADD IF NOT EXISTS migrated_from BIGINT;
CREATE INDEX IF NOT EXISTS release_logs_repo_name_idx ON release_logs (repo_name);
CREATE INDEX IF NOT EXISTS release_logs_repo_owner_idx ON release_logs (repo_owner DESC);
CREATE INDEX IF NOT EXISTS release_logs_repo_source_idx ON release_logs (repo_source);
-- modify computed_pipelines for migrations
ALTER TABLE computed_pipelines ADD IF NOT EXISTS migration_task_id VARCHAR(256);
-- create migration_task_queue table
CREATE TABLE IF NOT EXISTS migration_task_queue
(
  id             VARCHAR(256)                               NOT NULL CONSTRAINT migration_task_queue_pk PRIMARY KEY,
  status         VARCHAR(256)             DEFAULT 'queued'  NOT NULL CONSTRAINT migration_task_queue_status_check CHECK (status <> ''),
  last_step      VARCHAR(256)             DEFAULT 'waiting' NOT NULL CONSTRAINT migration_task_queue_last_step_check CHECK (last_step <> ''),
  builds         BIGINT                                     NOT NULL DEFAULT 0,
  releases       BIGINT                                     NOT NULL DEFAULT 0,
  total_duration BIGINT                                     NOT NULL DEFAULT 0,
  from_source    VARCHAR(256)                               NOT NULL,
  from_owner     VARCHAR(256)                               NOT NULL,
  from_name      VARCHAR(256)                               NOT NULL,
  to_source      VARCHAR(256)                               NOT NULL,
  to_owner       VARCHAR(256)                               NOT NULL,
  to_name        VARCHAR(256)                               NOT NULL,
  callback_url   VARCHAR(256),
  error_details  VARCHAR,
  queued_at      TIMESTAMP WITH TIME ZONE DEFAULT NOW()     NOT NULL,
  updated_at     TIMESTAMP WITH TIME ZONE DEFAULT NOW()     NOT NULL
);
CREATE UNIQUE INDEX IF NOT EXISTS unique_migration_task_queue ON migration_task_queue (from_source, from_owner, from_name, to_source, to_owner, to_name);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP INDEX IF EXISTS unique_migration_task_queue;
DROP TABLE IF EXISTS migration_task_queue;
ALTER TABLE computed_pipelines DROP COLUMN IF EXISTS migration_task_id;
DROP INDEX IF EXISTS release_logs_repo_source_idx;
DROP INDEX IF EXISTS release_logs_repo_owner_idx;
DROP INDEX IF EXISTS release_logs_repo_name_idx;
ALTER TABLE release_logs DROP COLUMN IF EXISTS migrated_from BIGINT;
DROP INDEX IF EXISTS releases_repo_source_idx;
DROP INDEX IF EXISTS releases_repo_owner_idx;
DROP INDEX IF EXISTS releases_repo_name_idx;
ALTER TABLE releases DROP COLUMN IF EXISTS migrated_from BIGINT;
ALTER TABLE build_versions DROP COLUMN IF EXISTS migrated_from BIGINT;
DROP INDEX IF EXISTS build_logs_repo_source_idx;
DROP INDEX IF EXISTS build_logs_repo_owner_idx;
DROP INDEX IF EXISTS build_logs_repo_name_idx;
ALTER TABLE build_logs DROP COLUMN IF EXISTS migrated_from BIGINT;
DROP INDEX IF EXISTS builds_repo_source_idx;
DROP INDEX IF EXISTS builds_repo_owner_idx;
DROP INDEX IF EXISTS builds_repo_name_idx;
ALTER TABLE builds DROP COLUMN IF EXISTS migrated_from BIGINT;
-- +goose StatementEnd
