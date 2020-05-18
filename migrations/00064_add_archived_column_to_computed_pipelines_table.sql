-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_pipelines ADD archived BOOL DEFAULT false;
CREATE INDEX computed_pipelines_archived_idx ON computed_pipelines (archived);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX computed_pipelines@computed_pipelines_archived_idx;
ALTER TABLE computed_pipelines DROP archived;