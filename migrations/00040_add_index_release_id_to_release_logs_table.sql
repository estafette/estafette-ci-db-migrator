-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE INDEX release_logs_release_id_idx ON release_logs (release_id);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX release_logs_build_id_idx;