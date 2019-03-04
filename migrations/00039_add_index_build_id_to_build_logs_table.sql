-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE INDEX build_logs_build_id_idx ON build_logs (build_id);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX build_logs@build_logs_build_id_idx;