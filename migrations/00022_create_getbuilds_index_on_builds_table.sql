-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE INDEX builds_get_pipeline_builds_idx ON builds (repo_source, repo_owner, repo_name, inserted_at DESC);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
