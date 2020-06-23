-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE releases ADD organizations JSONB, ADD COLUMN groups JSONB;
CREATE INVERTED INDEX releases_organizations ON releases (organizations);
CREATE INVERTED INDEX releases_groups ON releases (groups);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX releases@releases_organizations;
DROP INDEX releases@releases_groups;
ALTER TABLE releases DROP organizations, DROP groups;