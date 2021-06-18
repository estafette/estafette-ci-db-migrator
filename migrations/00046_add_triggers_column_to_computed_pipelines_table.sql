-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_pipelines ADD triggers JSONB;
CREATE INDEX computed_pipelines_triggers ON computed_pipelines USING GIN (triggers);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX computed_pipelines_triggers;
ALTER TABLE computed_pipelines DROP triggers;