-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE releases 
DROP COLUMN duration,
DROP COLUMN time_to_running;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE releases 
ADD COLUMN duration INTERVAL DEFAULT '0s',
ADD COLUMN time_to_running INTERVAL DEFAULT '0s';