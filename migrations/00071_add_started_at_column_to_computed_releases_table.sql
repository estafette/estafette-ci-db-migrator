-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_releases ADD started_at TIMESTAMPTZ;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE computed_releases DROP started_at;