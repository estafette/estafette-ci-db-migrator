-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE  IF EXISTS build_logs_v2 RENAME TO build_logs;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE build_logs RENAME TO build_logs_v2;