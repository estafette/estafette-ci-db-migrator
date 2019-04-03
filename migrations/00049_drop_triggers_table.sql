-- +goose Up
-- SQL in this section is executed when the migration is applied.
DROP TABLE IF EXISTS triggers;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
CREATE TABLE triggers (
	id INT NOT NULL,
	trigger_type VARCHAR(256) NULL,
	identifier VARCHAR(256) NULL,
	event_name VARCHAR(256) NULL,
	triggers JSONB NULL,
	CONSTRAINT "primary" PRIMARY KEY (id ASC),
	INVERTED INDEX triggers_triggers (triggers),
	UNIQUE INDEX triggers_trigger_type_identifier_event_name_idx (trigger_type ASC, identifier ASC, event_name ASC)
)