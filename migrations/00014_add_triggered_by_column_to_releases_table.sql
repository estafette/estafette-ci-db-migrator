-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE releases ADD triggered_by VARCHAR(256);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE releases DROP triggered_by;