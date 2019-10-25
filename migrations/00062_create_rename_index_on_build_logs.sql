-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE INDEX build_logs_rename_idx ON build_logs (repo_source, repo_owner, repo_name);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
