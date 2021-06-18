-- +goose Up
-- SQL in this section is executed when the migration is applied.
DROP TABLE IF EXISTS triggers;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
CREATE TABLE triggers (
  id INT PRIMARY KEY,
	trigger_type VARCHAR(256),
	identifier VARCHAR(256),
	event_name VARCHAR(256),
	triggers JSONB
);
CREATE UNIQUE INDEX triggers_trigger_type_identifier_event_name_idx ON triggers (trigger_type ASC, identifier ASC, event_name ASC);
CREATE INDEX triggers_triggers ON triggers USING GIN (triggers);