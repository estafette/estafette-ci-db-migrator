-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE IF NOT EXISTS computed_pipelines (
  id INT PRIMARY KEY DEFAULT unique_rowid(),
  pipeline_id INT,
	repo_source STRING(256) NULL,
	repo_owner STRING(256) NULL,
	repo_name STRING(256) NULL,
	repo_branch STRING(256) NULL,
	repo_revision STRING(256) NULL,
	build_version STRING(256) NULL,
	build_status STRING(256) NULL,
	labels JSONB NULL,
	manifest STRING NULL,
	inserted_at TIMESTAMPTZ NULL DEFAULT now(),
	updated_at TIMESTAMPTZ NULL DEFAULT now(),
	commits JSONB NULL,
	duration INTERVAL NULL DEFAULT '0s':::INTERVAL,
	release_targets JSONB NULL,
	INVERTED INDEX computed_pipelines_labels_idx (labels),
	INDEX computed_pipelines_build_status_idx (build_status ASC),
	INDEX computed_pipelines_inserted_at_idx (inserted_at ASC),
	INDEX computed_pipelines_pipeline_id_idx (pipeline_id ASC),
	UNIQUE INDEX computed_pipelines_order_by_idx (repo_source ASC, repo_owner ASC, repo_name ASC)
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS computed_pipelines;
