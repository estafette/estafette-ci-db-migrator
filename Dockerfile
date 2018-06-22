FROM scratch

LABEL maintainer="estafette.io" \
      description="The estafette-ci-db-migrator is the component that handles updating the db schema"

COPY ca-certificates.crt /etc/ssl/certs/
COPY estafette-ci-db-migrator /
COPY migrations /migrations

ENTRYPOINT ["/estafette-ci-db-migrator"]
