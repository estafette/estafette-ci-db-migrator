-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE IF NOT EXISTS notifications (
  id SERIAL PRIMARY KEY,
  repo_source VARCHAR(256),
  repo_owner VARCHAR(256),
  repo_name VARCHAR(256),
  notifications JSONB NULL,
  inserted_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  organizations JSONB,
  groups JSONB,
  INDEX notifications_get_pipeline_notifications_idx (repo_source ASC, repo_owner ASC, repo_name ASC, inserted_at DESC),
  INVERTED INDEX notifications_organizations (organizations),
  INVERTED INDEX notifications_groups (groups)
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS notifications;