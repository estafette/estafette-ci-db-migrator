-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE builds ADD organizations JSONB, ADD COLUMN groups JSONB;
CREATE INDEX builds_organizations ON builds USING GIN (organizations);
CREATE INDEX builds_groups ON builds USING GIN (groups);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX builds@builds_organizations;
DROP INDEX builds@builds_groups;
ALTER TABLE builds DROP organizations, DROP groups;