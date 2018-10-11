-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE build_logs_v2 ADD build_id INT NULL;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
