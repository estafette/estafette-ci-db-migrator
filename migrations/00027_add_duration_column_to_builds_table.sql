-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE builds ADD duration INTERVAL DEFAULT '0s';

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE builds DROP duration;