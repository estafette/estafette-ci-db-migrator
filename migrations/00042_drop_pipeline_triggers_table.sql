-- +goose Up
-- SQL in this section is executed when the migration is applied.
DROP TABLE IF EXISTS pipeline_triggers;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
CREATE TABLE computed_pipelines (
	id SERIAL PRIMARY KEY,
	pipeline_id INT NULL,
	repo_source STRING(256) NULL,
	repo_owner STRING(256) NULL,
	repo_name STRING(256) NULL,
	repo_branch STRING(256) NULL,
	repo_revision STRING(256) NULL,
	build_version STRING(256) NULL,
	build_status STRING(256) NULL,
	labels JSONB NULL,
	manifest STRING NULL,
	inserted_at TIMESTAMPTZ NULL DEFAULT now():::TIMESTAMPTZ,
	updated_at TIMESTAMPTZ NULL DEFAULT now():::TIMESTAMPTZ,
	commits JSONB NULL,
	duration INTERVAL NULL DEFAULT '0s':::INTERVAL,
	release_targets JSONB NULL,
	first_inserted_at TIMESTAMPTZ NULL DEFAULT now():::TIMESTAMPTZ,
	INDEX computed_pipelines_labels_idx USING GIN (labels),
	INDEX computed_pipelines_build_status_idx (build_status ASC),
	INDEX computed_pipelines_inserted_at_idx (inserted_at ASC),
	INDEX computed_pipelines_pipeline_id_idx (pipeline_id ASC),
	UNIQUE INDEX computed_pipelines_order_by_idx (repo_source ASC, repo_owner ASC, repo_name ASC)
)