-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE builds
ALTER cpu_request type FLOAT,
ALTER cpu_limit type FLOAT,
ALTER cpu_max_usage type FLOAT,
ALTER memory_request type FLOAT,
ALTER memory_limit type FLOAT,
ALTER memory_max_usage type FLOAT;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
