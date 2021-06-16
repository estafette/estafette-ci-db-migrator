-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE catalog_entities (
  id SERIAL PRIMARY KEY,
  parent_key VARCHAR(256) NULL,
  parent_value VARCHAR(256) NULL,
  entity_key VARCHAR(256) NULL,
  entity_value VARCHAR(256) NULL,
  linked_pipeline VARCHAR(256) NULL,
  labels JSONB NULL,
  entity_metadata JSONB NULL,
  inserted_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);
CREATE INDEX catalog_entities_parent ON catalog_entities (parent_key, parent_value);
CREATE INDEX catalog_entities_entity ON catalog_entities (entity_key, entity_value);
CREATE INDEX catalog_entities_linked_pipeline ON catalog_entities (linked_pipeline);
CREATE INDEX catalog_entities_labels ON catalog_entities USING GIN (labels);
CREATE INDEX catalog_entities_entity_metadata ON catalog_entities USING GIN (entity_metadata);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS catalog_entities;