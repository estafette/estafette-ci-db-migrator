-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE builds ADD releases JSONB;
CREATE INVERTED INDEX IF NOT EXISTS builds_releases ON builds (releases);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX builds@builds_releases;
ALTER TABLE builds DROP releases;