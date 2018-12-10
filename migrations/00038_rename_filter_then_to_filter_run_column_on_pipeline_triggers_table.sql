-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE pipeline_triggers RENAME COLUMN trigger_then TO trigger_run;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE pipeline_triggers RENAME COLUMN trigger_run TO trigger_then;
