-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_pipelines ADD last_updated_at TIMESTAMPTZ NULL DEFAULT now();

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE computed_pipelines DROP last_updated_at;