-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE builds ADD push_event JSONB;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE builds DROP push_event;