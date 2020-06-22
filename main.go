package main

import (
	"runtime"

	"github.com/alecthomas/kingpin"
	foundation "github.com/estafette/estafette-foundation"
	"github.com/rs/zerolog/log"
)

var (
	appgroup  string
	app       string
	version   string
	branch    string
	revision  string
	buildDate string
	goVersion = runtime.Version()
)

var (
	// flags
	cockroachDatabase         = kingpin.Flag("cockroach-database", "CockroachDB database.").Envar("COCKROACH_DATABASE").String()
	cockroachHost             = kingpin.Flag("cockroach-host", "CockroachDB host.").Envar("COCKROACH_HOST").String()
	cockroachInsecure         = kingpin.Flag("cockroach-insecure", "CockroachDB insecure connection.").Envar("COCKROACH_INSECURE").Bool()
	cockroachCertificateDir   = kingpin.Flag("cockroach-certs-dir", "CockroachDB certificate directory.").Envar("COCKROACH_CERTS_DIR").String()
	cockroachPort             = kingpin.Flag("cockroach-port", "CockroachDB port.").Envar("COCKROACH_PORT").Int()
	cockroachUser             = kingpin.Flag("cockroach-user", "CockroachDB user.").Envar("COCKROACH_USER").String()
	cockroachPassword         = kingpin.Flag("cockroach-password", "CockroachDB password.").Envar("COCKROACH_PASSWORD").String()
	cockroachConnectionString = kingpin.Flag("cockroach-connection-string", "CockroachDB connection string.").Envar("COCKROACH_CONNECTION_STRING").String()
	sslMode                   = kingpin.Flag("ssl-mode", "SSL Mode used to connect to cockroachdb.").Default("verify-full").OverrideDefaultFromEnvar("SSL_MODE").String()
	certificateAuthorityPath  = kingpin.Flag("ca-path", "Path to certificate authority (CA) public certificate.").Default("/var/run/secrets/kubernetes.io/serviceaccount/ca.crt").OverrideDefaultFromEnvar("CA_PATH").String()
)

func main() {

	// parse command line parameters
	kingpin.Parse()

	// init log format from envvar ESTAFETTE_LOG_FORMAT
	foundation.InitLoggingFromEnv(appgroup, app, version, branch, revision, buildDate)

	// set up database and update schema
	cockroachDBClient := NewCockroachDBClient(*cockroachConnectionString, *cockroachDatabase, *cockroachHost, *cockroachInsecure, *sslMode, *cockroachCertificateDir, *certificateAuthorityPath, *cockroachPort, *cockroachUser, *cockroachPassword)
	err := cockroachDBClient.Connect()
	if err != nil {
		log.Warn().Err(err).Msg("Failed connecting to database")
	}
	err = cockroachDBClient.MigrateSchema()
	if err != nil {
		log.Fatal().Err(err).Msg("Failed migrating database schema")
	}

	log.Info().Msg("Successfully migrated database schema")
}
