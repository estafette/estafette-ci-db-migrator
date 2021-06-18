-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE computed_releases (
	id SERIAL NOT NULL,
    release_id INT,
	repo_source VARCHAR(256) NULL,
	repo_owner VARCHAR(256) NULL,
	repo_name VARCHAR(256) NULL,
	release VARCHAR(256) NULL,
	release_version VARCHAR(256) NULL,
	release_status VARCHAR(256) NULL,
	inserted_at TIMESTAMPTZ NULL DEFAULT now(),
	updated_at TIMESTAMPTZ NULL DEFAULT now(),
	triggered_by VARCHAR(256) NULL,
	duration INTERVAL NULL DEFAULT '0s',
	release_action VARCHAR(256) NULL DEFAULT '':::STRING,
	first_inserted_at TIMESTAMPTZ NULL DEFAULT now()
);
CREATE INDEX computed_releases_release_status_idx ON computed_releases (release_status ASC);
CREATE INDEX computed_releases_inserted_at_idx ON computed_releases (inserted_at ASC);
CREATE INDEX computed_releases_release_id_idx ON computed_releases (release_id ASC);
CREATE UNIQUE INDEX computed_releases_order_by_idx ON computed_releases (repo_source ASC, repo_owner ASC, repo_name ASC, release ASC, release_action ASC);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS computed_releases;