-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_releases ADD organizations JSONB, ADD COLUMN groups JSONB;
CREATE INDEX computed_releases_organizations ON computed_releases USING GIN (organizations);
CREATE INDEX computed_releases_groups ON computed_releases USING GIN (groups);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX computed_releases_organizations;
DROP INDEX computed_releases_groups;
ALTER TABLE computed_releases DROP organizations, DROP groups;