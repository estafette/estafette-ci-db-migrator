-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_releases ADD duration_running INTERVAL AS (age(updated_at, COALESCE(started_at,inserted_at))) STORED;
ALTER TABLE computed_releases ADD duration_pending INTERVAL AS (age(COALESCE(started_at,inserted_at), inserted_at)) STORED;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE computed_releases DROP duration_running;
ALTER TABLE computed_releases DROP duration_pending;