-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE clients ADD active BOOL DEFAULT true;
CREATE INDEX clients_active ON clients (active);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX clients;
ALTER TABLE clients DROP active;