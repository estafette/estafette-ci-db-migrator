-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE builds ADD triggers JSONB;
CREATE INVERTED INDEX IF NOT EXISTS builds_triggers ON builds (triggers);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX builds@builds_triggers;
ALTER TABLE builds DROP triggers;