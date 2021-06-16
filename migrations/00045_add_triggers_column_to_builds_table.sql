-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE builds ADD triggers JSONB;
CREATE INDEX builds_triggers ON builds USING GIN (triggers);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX builds@builds_triggers;
ALTER TABLE builds DROP triggers;