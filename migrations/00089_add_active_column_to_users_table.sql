-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE users ADD active BOOL DEFAULT true;
CREATE INDEX users_active ON users (active);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX users_active@users;
ALTER TABLE users DROP active;