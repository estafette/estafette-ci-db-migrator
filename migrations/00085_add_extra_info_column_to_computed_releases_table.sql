-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_releases ADD extra_info JSONB;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE computed_releases DROP extra_info;