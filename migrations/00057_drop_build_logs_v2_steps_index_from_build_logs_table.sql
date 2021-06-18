-- +goose Up
-- SQL in this section is executed when the migration is applied.
DROP INDEX build_logs_v2_steps;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
CREATE INDEX build_logs_v2_steps ON build_logs USING GIN (steps);