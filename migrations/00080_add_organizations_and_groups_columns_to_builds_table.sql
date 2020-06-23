-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE builds ADD organizations JSONB, ADD COLUMN groups JSONB;
CREATE INVERTED INDEX builds_organizations ON builds (organizations);
CREATE INVERTED INDEX builds_groups ON builds (groups);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX builds@builds_organizations;
DROP INDEX builds@builds_groups;
ALTER TABLE builds DROP organizations, DROP groups;