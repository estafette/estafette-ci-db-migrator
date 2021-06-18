-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_pipelines ADD organizations JSONB, ADD COLUMN groups JSONB;
CREATE INDEX computed_pipelines_organizations ON computed_pipelines USING GIN (organizations);
CREATE INDEX computed_pipelines_groups ON computed_pipelines USING GIN (groups);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX computed_pipelines_organizations;
DROP INDEX computed_pipelines_groups;
ALTER TABLE computed_pipelines DROP organizations, DROP groups;