-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE build_logs_v2 TO build_logs;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE build_logs TO build_logs_v2;