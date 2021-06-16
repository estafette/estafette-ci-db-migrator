-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE releases (
  id SERIAL PRIMARY KEY,
  repo_source VARCHAR(256),
  repo_owner VARCHAR(256),
  repo_name VARCHAR(256),
  release VARCHAR(256),
  release_version VARCHAR(256),
  release_status VARCHAR(256),
  inserted_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS releases;