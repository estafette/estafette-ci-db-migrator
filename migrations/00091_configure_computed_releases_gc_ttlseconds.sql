-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE computed_releases CONFIGURE ZONE USING gc.ttlseconds = 3600;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE computed_releases CONFIGURE ZONE USING gc.ttlseconds = 90000;
