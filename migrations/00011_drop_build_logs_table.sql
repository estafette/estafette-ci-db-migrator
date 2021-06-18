-- +goose Up
-- SQL in this section is executed when the migration is applied.
DROP TABLE IF EXISTS build_logs;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
CREATE TABLE build_logs (
	id SERIAL PRIMARY KEY,
	repo_full_name VARCHAR(256),
	repo_branch VARCHAR(256),
	repo_revision VARCHAR(256),
	repo_source VARCHAR(256),
	log_text TEXT,
	inserted_at TIMESTAMP DEFAULT now()
);
CREATE INDEX builds_logs_repo_full_name_repo_branch_repo_revision_repo_source_idx ON build_logs (repo_full_name ASC, repo_branch ASC, repo_revision ASC, repo_source ASC);