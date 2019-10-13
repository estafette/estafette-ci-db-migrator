-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE releases
DROP COLUMN cpu_request,
DROP COLUMN cpu_limit,
DROP COLUMN cpu_max_usage,
DROP COLUMN memory_request,
DROP COLUMN memory_limit,
DROP COLUMN memory_max_usage;

ALTER TABLE releases
ADD COLUMN cpu_request FLOAT NULL,
ADD COLUMN cpu_limit FLOAT NULL,
ADD COLUMN cpu_max_usage FLOAT NULL,
ADD COLUMN memory_request FLOAT NULL,
ADD COLUMN memory_limit FLOAT NULL,
ADD COLUMN memory_max_usage FLOAT NULL;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
