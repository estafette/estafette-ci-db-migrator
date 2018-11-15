-- +goose Up
-- SQL in this section is executed when the migration is applied.
DROP INDEX release_logs@release_logs_repo_source_repo_owner_repo_name_release_id_idx CASCADE;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
