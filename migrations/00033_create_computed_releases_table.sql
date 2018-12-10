-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE IF NOT EXISTS computed_releases (
	id INT NOT NULL DEFAULT unique_rowid(),
    release_id INT,
	repo_source STRING(256) NULL,
	repo_owner STRING(256) NULL,
	repo_name STRING(256) NULL,
	release STRING(256) NULL,
	release_version STRING(256) NULL,
	release_status STRING(256) NULL,
	inserted_at TIMESTAMPTZ NULL DEFAULT now(),
	updated_at TIMESTAMPTZ NULL DEFAULT now(),
	triggered_by STRING(256) NULL,
	duration INTERVAL NULL DEFAULT '0s':::INTERVAL,
	release_action VARCHAR(256) NULL DEFAULT '':::STRING,
	first_inserted_at TIMESTAMPTZ NULL DEFAULT now(),
	INDEX computed_releases_release_status_idx (release_status ASC),
	INDEX computed_releases_inserted_at_idx (inserted_at ASC),
	INDEX computed_releases_release_id_idx (release_id ASC),
    UNIQUE INDEX computed_releases_order_by_idx (repo_source ASC, repo_owner ASC, repo_name ASC, release ASC, release_action ASC)
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS computed_releases;