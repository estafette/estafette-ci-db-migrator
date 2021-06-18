-- +goose Up
-- SQL in this section is executed when the migration is applied.
DROP INDEX release_logs_steps;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
CREATE INDEX release_logs_steps ON release_logs USING GIN (steps);