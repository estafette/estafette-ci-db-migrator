-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE triggers (
  id INT PRIMARY KEY,
  trigger_type VARCHAR(256),
  identifier VARCHAR(256),
  event_name VARCHAR(256),
  triggers JSONB
);
CREATE INDEX triggers_trigger_type_identifier_idx ON triggers (trigger_type, identifier, event_name);
CREATE INDEX triggers_triggers ON triggers USING GIN (triggers);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS triggers;