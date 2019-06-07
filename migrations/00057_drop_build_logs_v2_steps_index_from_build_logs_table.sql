-- +goose Up
-- SQL in this section is executed when the migration is applied.
DROP INDEX build_logs@build_logs_v2_steps;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
CREATE INVERTED INDEX IF NOT EXISTS build_logs_v2_steps ON build_logs (steps);