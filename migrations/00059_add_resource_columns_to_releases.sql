-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE
    releases
ADD
    time_to_running INTERVAL DEFAULT '0s',
    cpu_request REAL NULL,
    cpu_limit REAL NULL,
    cpu_max_usage REAL NULL,
    memory_request REAL NULL,
    memory_limit REAL NULL,
    memory_max_usage REAL NULL;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE
    releases
DROP
    time_to_running,
    cpu_request,
    cpu_limit,
    cpu_max_usage,
    memory_request,
    memory_limit,
    memory_max_usage;