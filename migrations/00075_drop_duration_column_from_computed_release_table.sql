-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_releases DROP COLUMN duration;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE computed_releases ADD COLUMN duration INTERVAL DEFAULT '0s';