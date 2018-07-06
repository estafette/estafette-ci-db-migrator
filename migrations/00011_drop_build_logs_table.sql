-- +goose Up
-- SQL in this section is executed when the migration is applied.
DROP TABLE IF EXISTS build_logs;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
CREATE TABLE build_logs (
	id INT NOT NULL DEFAULT unique_rowid(),
	repo_full_name STRING(256) NULL,
	repo_branch STRING(256) NULL,
	repo_revision STRING(256) NULL,
	repo_source STRING(256) NULL,
	log_text STRING NULL,
	inserted_at TIMESTAMP NULL DEFAULT now(),
	CONSTRAINT "primary" PRIMARY KEY (id ASC),
	INDEX builds_logs_repo_full_name_repo_branch_repo_revision_repo_source_idx (repo_full_name ASC, repo_branch ASC, repo_revision ASC, repo_source ASC),
	FAMILY "primary" (id, repo_full_name, repo_branch, repo_revision, repo_source, log_text, inserted_at)
)