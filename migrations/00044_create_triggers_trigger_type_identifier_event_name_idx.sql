-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE UNIQUE INDEX triggers_trigger_type_identifier_event_name_idx ON triggers (trigger_type, identifier, event_name);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
