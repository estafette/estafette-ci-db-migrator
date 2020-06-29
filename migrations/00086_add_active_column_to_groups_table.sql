-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE groups ADD active BOOL DEFAULT true;
CREATE INDEX groups_active ON groups (active);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP INDEX groups_active@groups;
ALTER TABLE groups DROP active;