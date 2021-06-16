-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE IF NOT EXISTS release_logs (
  id SERIAL PRIMARY KEY,
  repo_source VARCHAR(256),
  repo_owner VARCHAR(256),
  repo_name VARCHAR(256),
  release_id INT,
  steps JSONB,
  inserted_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  UNIQUE INDEX release_logs_repo_source_repo_owner_repo_name_release_id_idx (repo_source, repo_owner, repo_name, release_id),
  INDEX release_logs_steps USING GIN (steps)
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS release_logs;