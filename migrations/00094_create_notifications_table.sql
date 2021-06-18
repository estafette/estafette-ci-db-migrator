-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  link_type VARCHAR(256),
  link_id VARCHAR(256),
  link_detail JSONB,
  source VARCHAR(256),
  notifications JSONB,
  inserted_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  organizations JSONB,
  groups JSONB
);
CREATE INDEX notifications_get_link_notifications_idx ON notifications (link_type ASC, link_id ASC, inserted_at DESC);
CREATE INDEX notifications_link_detail ON notifications USING GIN (link_detail);
CREATE INDEX notifications_organizations ON notifications USING GIN (organizations);
CREATE INDEX notifications_groups ON notifications USING GIN (groups);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS notifications;