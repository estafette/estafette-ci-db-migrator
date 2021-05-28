-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE IF NOT EXISTS bot_logs (
  id SERIAL PRIMARY KEY,
  repo_source VARCHAR(256),
  repo_owner VARCHAR(256),
  repo_name VARCHAR(256),
  bot_id INT,
  steps JSONB,
  inserted_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  INDEX bot_logs_bot_id_idx (bot_id ASC),
  INDEX bot_logs_rename_idx (repo_source ASC, repo_owner ASC, repo_name ASC)
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS bot_logs;