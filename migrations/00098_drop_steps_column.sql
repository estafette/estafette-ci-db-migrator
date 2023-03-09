-- +goose Up
-- +goose StatementBegin
ALTER TABLE build_logs DROP COLUMN IF EXISTS steps;
ALTER TABLE release_logs DROP COLUMN IF EXISTS steps;
-- +goose StatementEnd
