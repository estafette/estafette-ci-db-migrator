-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE IF NOT EXISTS catalog_entities (
  id SERIAL PRIMARY KEY,
  parent_key VARCHAR(256) NULL,
  parent_value VARCHAR(256) NULL,
  entity_key VARCHAR(256) NULL,
  entity_value VARCHAR(256) NULL,
  linked_pipeline VARCHAR(256) NULL,
  labels JSONB NULL,
  entity_metadata JSONB NULL,
  inserted_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  INDEX catalog_entities_parent (parent_key, parent_value),
  INDEX catalog_entities_entity (entity_key, entity_value),
  INDEX catalog_entities_linked_pipeline (linked_pipeline)
);
CREATE INDEX IF NOT EXISTS catalog_entities_labels ON catalog_entities USING GIN (labels);
CREATE INDEX IF NOT EXISTS catalog_entities_entity_metadata ON catalog_entities USING GIN (entity_metadata);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS catalog_entities;