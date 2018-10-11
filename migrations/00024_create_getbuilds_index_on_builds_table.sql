-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE INDEX builds_get_pipelines_idx ON builds (inserted_at DESC, build_status);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
