-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE builds ADD releases JSONB;
CREATE INDEX IF NOT EXISTS builds_releases ON builds USING GIN (releases);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX builds@builds_releases;
ALTER TABLE builds DROP releases;