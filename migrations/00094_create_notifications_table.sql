-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE IF NOT EXISTS notifications (
  id SERIAL PRIMARY KEY,
  link_type VARCHAR(256),
  link_id VARCHAR(256),
  link_detail JSONB,
  source VARCHAR(256),
  notifications JSONB NULL,
  inserted_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  organizations JSONB,
  groups JSONB,
  INDEX notifications_get_link_notifications_idx (link_type ASC, link_id ASC, inserted_at DESC),
  INVERTED INDEX notifications_link_detail (link_detail),
  INVERTED INDEX notifications_organizations (organizations),
  INVERTED INDEX notifications_groups (groups)
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS notifications;