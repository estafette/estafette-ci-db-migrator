-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE IF NOT EXISTS github_push_events (
  id INT PRIMARY KEY DEFAULT unique_rowid(),
  repo_source VARCHAR(256),
  repo_owner VARCHAR(256),
  repo_name VARCHAR(256),
  repo_revision VARCHAR(256),
  push_event JSONB,
  inserted_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  UNIQUE INDEX github_push_events_repo_source_repo_owner_repo_name_repo_revision_idx (repo_source, repo_owner, repo_name, repo_revision)
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS github_push_events;