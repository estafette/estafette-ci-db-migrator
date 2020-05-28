-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE builds ADD duration_running INTERVAL AS (age(updated_at, COALESCE(started_at,inserted_at))) STORED;
ALTER TABLE builds ADD duration_pending INTERVAL AS (age(COALESCE(started_at,inserted_at), inserted_at)) STORED;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE builds DROP duration_running;
ALTER TABLE builds DROP duration_pending;