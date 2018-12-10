-- +goose Up
-- SQL in this section is executed when the migration is applied.
DROP TABLE IF EXISTS bitbucket_push_events;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
