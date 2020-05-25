-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_pipelines ADD frequent_releasers JSONB;
CREATE INVERTED INDEX IF NOT EXISTS computed_pipelines_frequent_releasers ON computed_pipelines (frequent_releasers);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX computed_pipelines@computed_pipelines_frequent_releasers;
ALTER TABLE computed_pipelines DROP frequent_releasers;