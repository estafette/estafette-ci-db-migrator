-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE build_logs_v2 ADD CONSTRAINT build_logs_v2_repo_source_repo_owner_repo_name_repo_branch_repo_revision_idx UNIQUE (repo_source, repo_owner, repo_name, repo_branch, repo_revision);
ALTER TABLE build_logs_v2 DROP CONSTRAINT build_logs_v2_repo_source_repo_owner_repo_name_repo_revision_idx;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
