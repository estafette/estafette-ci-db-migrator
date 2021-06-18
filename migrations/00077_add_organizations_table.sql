-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE organizations (
  id SERIAL PRIMARY KEY,
  organization_data JSONB,
  inserted_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);
CREATE INDEX organizations_organization_data ON organizations USING GIN (organization_data);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS organizations;