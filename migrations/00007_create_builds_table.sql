-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE builds (
  id SERIAL PRIMARY KEY,
  repo_source VARCHAR(256),
  repo_owner VARCHAR(256),
  repo_name VARCHAR(256),
  repo_branch VARCHAR(256),
  repo_revision VARCHAR(256),
  build_version VARCHAR(256),
  build_status VARCHAR(256),
  labels JSONB,
  manifest TEXT,
  inserted_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);
CREATE UNIQUE INDEX builds_repo_source_repo_owner_repo_name_repo_revision_idx ON builds (repo_source, repo_owner, repo_name, repo_revision);
CREATE INDEX builds_labels ON builds USING GIN (labels);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS builds;