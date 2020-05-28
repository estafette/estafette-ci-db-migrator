-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE releases ADD duration_running INTERVAL AS (age(updated_at, COALESCE(started_at,inserted_at))) STORED;
ALTER TABLE releases ADD duration_pending INTERVAL AS (age(COALESCE(started_at,inserted_at), inserted_at)) STORED;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE releases DROP duration_running;
ALTER TABLE releases DROP duration_pending;