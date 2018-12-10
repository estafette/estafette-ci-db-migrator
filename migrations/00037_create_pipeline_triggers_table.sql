-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE IF NOT EXISTS pipeline_triggers (
  id INT PRIMARY KEY DEFAULT unique_rowid(),
  repo_source VARCHAR(256),
  repo_owner VARCHAR(256),
  repo_name VARCHAR(256),
	trigger_event STRING(256) NULL,
  trigger_filter JSONB,
  trigger_then JSONB,
	inserted_at TIMESTAMPTZ NULL DEFAULT now(),
	updated_at TIMESTAMPTZ NULL DEFAULT now(),
	INDEX pipeline_triggers_repo_source_repo_owner_repo_name_idx (repo_source ASC, repo_owner ASC, repo_name ASC),
  INDEX pipeline_triggers_trigger_event_idx (trigger_event ASC),
  INVERTED INDEX pipeline_triggers_trigger_filter_idx (trigger_filter ASC)
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS pipeline_triggers;