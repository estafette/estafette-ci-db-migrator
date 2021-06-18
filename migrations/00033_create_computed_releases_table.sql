-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE computed_releases (
	id SERIAL NOT,
    release_id INT,
	repo_source VARCHAR(256),
	repo_owner VARCHAR(256),
	repo_name VARCHAR(256),
	release VARCHAR(256),
	release_version VARCHAR(256),
	release_status VARCHAR(256),
	inserted_at TIMESTAMPTZ DEFAULT now(),
	updated_at TIMESTAMPTZ DEFAULT now(),
	triggered_by VARCHAR(256),
	duration INTERVAL DEFAULT '0s',
	release_action VARCHAR(256) DEFAULT '':::STRING,
	first_inserted_at TIMESTAMPTZ DEFAULT now()
);
CREATE INDEX computed_releases_release_status_idx ON computed_releases (release_status ASC);
CREATE INDEX computed_releases_inserted_at_idx ON computed_releases (inserted_at ASC);
CREATE INDEX computed_releases_release_id_idx ON computed_releases (release_id ASC);
CREATE UNIQUE INDEX computed_releases_order_by_idx ON computed_releases (repo_source ASC, repo_owner ASC, repo_name ASC, release ASC, release_action ASC);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE IF EXISTS computed_releases;