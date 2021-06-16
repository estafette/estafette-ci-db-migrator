-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE INDEX release_logs_rename_idx ON release_logs (repo_source, repo_owner, repo_name);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX IF EXISTS release_logs@release_logs_rename_idx;