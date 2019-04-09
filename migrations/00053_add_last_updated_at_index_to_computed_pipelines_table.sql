-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE INDEX computed_pipelines_last_updated_at_idx ON computed_pipelines (last_updated_at);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX computed_pipelines@computed_pipelines_last_updated_at_idx;