-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE releases ADD release_action VARCHAR(256) DEFAULT '';

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE releases DROP release_action;