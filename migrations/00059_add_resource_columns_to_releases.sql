-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE releases
ADD COLUMN time_to_running INTERVAL DEFAULT '0s',
ADD COLUMN cpu_request REAL,
ADD COLUMN cpu_limit REAL,
ADD COLUMN cpu_max_usage REAL,
ADD COLUMN memory_request REAL,
ADD COLUMN memory_limit REAL,
ADD COLUMN memory_max_usage REAL;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE releases
DROP COLUMN time_to_running,
DROP COLUMN cpu_request,
DROP COLUMN cpu_limit,
DROP COLUMN cpu_max_usage,
DROP COLUMN memory_request,
DROP COLUMN memory_limit,
DROP COLUMN memory_max_usage;