-- +goose Up
-- SQL in this section is executed when the migration is applied.
DROP INDEX build_logs_v2@build_logs_v2_repo_source_repo_owner_repo_name_repo_branch_repo_revision_idx CASCADE;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
