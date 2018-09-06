-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE builds ADD CONSTRAINT builds_repo_source_repo_owner_repo_name_repo_branch_repo_revision_idx UNIQUE (repo_source, repo_owner, repo_name, repo_branch, repo_revision);
ALTER TABLE builds DROP CONSTRAINT builds_repo_source_repo_owner_repo_name_repo_revision_idx;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
