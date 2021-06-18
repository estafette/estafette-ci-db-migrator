-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE releases ADD organizations JSONB, ADD COLUMN groups JSONB;
CREATE INDEX releases_organizations ON releases USING GIN (organizations);
CREATE INDEX releases_groups ON releases USING GIN (groups);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX releases_organizations;
DROP INDEX releases_groups;
ALTER TABLE releases DROP organizations, DROP groups;