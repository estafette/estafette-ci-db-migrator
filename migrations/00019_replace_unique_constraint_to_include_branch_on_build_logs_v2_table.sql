-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE UNIQUE INDEX build_logs_v2_repo_source_repo_owner_repo_name_repo_branch_repo_revision_idx ON build_logs_v2 (repo_source, repo_owner, repo_name, repo_branch, repo_revision);

DROP INDEX build_logs_v2_repo_source_repo_owner_repo_name_repo_revision_idx CASCADE;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
