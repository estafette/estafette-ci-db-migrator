-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE organizations ADD active BOOL DEFAULT true;
CREATE INDEX organizations_active ON organizations (active);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX organizations;
ALTER TABLE organizations DROP active;