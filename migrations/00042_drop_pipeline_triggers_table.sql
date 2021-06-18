-- +goose Up
-- SQL in this section is executed when the migration is applied.
DROP TABLE IF EXISTS pipeline_triggers;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
CREATE TABLE pipeline_triggers (
  id SERIAL PRIMARY KEY,
  repo_source VARCHAR(256),
  repo_owner VARCHAR(256),
  repo_name VARCHAR(256),
	trigger_event VARCHAR(256),
  trigger_filter JSONB,
  trigger_run JSONB,
	inserted_at TIMESTAMPTZ DEFAULT now(),
	updated_at TIMESTAMPTZ DEFAULT now()
);
CREATE INDEX pipeline_triggers_repo_source_repo_owner_repo_name_idx ON pipeline_triggers (repo_source ASC, repo_owner ASC, repo_name ASC);
CREATE INDEX pipeline_triggers_trigger_event_idx ON pipeline_triggers (trigger_event ASC);
CREATE INDEX pipeline_triggers_trigger_filter_idx ON pipeline_triggers USING GIN (trigger_filter);