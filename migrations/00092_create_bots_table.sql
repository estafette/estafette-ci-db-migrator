-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE IF NOT EXISTS bots (
  id SERIAL PRIMARY KEY,
  repo_source VARCHAR(256),
  repo_owner VARCHAR(256),
  repo_name VARCHAR(256),
  bot VARCHAR(256),
  bot_status VARCHAR(256),
  triggered_by_event JSONB NULL,
  inserted_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  started_at TIMESTAMPTZ NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  cpu_request FLOAT8,
  cpu_limit FLOAT8,
  cpu_max_usage FLOAT8,
  memory_request FLOAT8,
  memory_limit FLOAT8,
  memory_max_usage FLOAT8,
  organizations JSONB,
  groups JSONB,
  INDEX bots_get_pipeline_bots_idx (repo_source ASC, repo_owner ASC, repo_name ASC, inserted_at DESC)
);
CREATE INDEX IF NOT EXISTS bots_organizations ON bots USING GIN (organizations);
CREATE INDEX IF NOT EXISTS bots_groups ON bots USING GIN (groups);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS bots;