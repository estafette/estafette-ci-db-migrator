# Estafette CI

The `estafette-ci-db-migrator` component is part of the Estafette CI system documented at https://estafette.io.

Please file any issues related to Estafette CI at https://github.com/estafette/estafette-ci-central/issues

## Estafette-ci-db-migrator

This component runs as a Kubernetes job to update the database schema if needed.

## Development

To start development run

```bash
git clone git@github.com:estafette/estafette-ci-db-migrator.git
cd estafette-ci-db-migrator
```

Before committing your changes run

```bash
go test `go list ./... | grep -v /vendor/`
```