-- +goose Up
-- SQL in this section is executed when the migration is applied.
DROP INDEX triggers@triggers_trigger_type_identifier_idx;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
