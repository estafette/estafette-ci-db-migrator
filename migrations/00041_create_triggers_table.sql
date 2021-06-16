-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE IF NOT EXISTS triggers (
  id INT PRIMARY KEY,
  trigger_type VARCHAR(256),
  identifier VARCHAR(256),
  event_name VARCHAR(256),
  triggers JSONB,
  INDEX triggers_trigger_type_identifier_idx (trigger_type, identifier, event_name),
  INDEX triggers_triggers USING GIN (triggers)
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS triggers;