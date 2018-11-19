-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE builds ADD release_targets JSONB;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE builds DROP release_targets;