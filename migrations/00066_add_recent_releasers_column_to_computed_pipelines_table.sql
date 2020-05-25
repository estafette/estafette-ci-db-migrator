-- +goose NO TRANSACTION
-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_pipelines ADD recent_releasers JSONB;
CREATE INVERTED INDEX IF NOT EXISTS computed_pipelines_recent_releasers ON computed_pipelines (recent_releasers);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX computed_pipelines@computed_pipelines_recent_releasers;
ALTER TABLE computed_pipelines DROP recent_releasers;