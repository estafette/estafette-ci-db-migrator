-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_pipelines ADD frequent_committers JSONB;
CREATE INVERTED INDEX IF NOT EXISTS computed_pipelines_frequent_committers ON computed_pipelines (frequent_committers);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX computed_pipelines@computed_pipelines_frequent_committers;
ALTER TABLE computed_pipelines DROP frequent_committers;