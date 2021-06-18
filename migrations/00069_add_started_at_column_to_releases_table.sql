-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE releases ADD started_at TIMESTAMPTZ;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE releases DROP started_at;