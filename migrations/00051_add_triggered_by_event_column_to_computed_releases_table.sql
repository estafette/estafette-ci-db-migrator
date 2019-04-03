-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_releases ADD triggered_by_event JSONB;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE computed_releases DROP triggered_by_event;