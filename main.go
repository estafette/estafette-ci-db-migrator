package main

import (
	stdlog "log"
	"os"
	"runtime"

	"github.com/alecthomas/kingpin"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

var (
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
)

func main() {

	// parse command line parameters
	kingpin.Parse()

	// configure json logging
	initLogging()

	// set up database and update schema
	cockroachDBClient := NewCockroachDBClient(*cockroachConnectionString, *cockroachDatabase, *cockroachHost, *cockroachInsecure, *cockroachCertificateDir, *cockroachPort, *cockroachUser, *cockroachPassword)
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

func initLogging() {

	// log as severity for stackdriver logging to recognize the level
	zerolog.LevelFieldName = "severity"

	// set some default fields added to all logs
	log.Logger = zerolog.New(os.Stdout).With().
		Timestamp().
		Str("app", "estafette-ci-db-migrator").
		Str("version", version).
		Logger()

	// use zerolog for any logs sent via standard log library
	stdlog.SetFlags(0)
	stdlog.SetOutput(log.Logger)

	// log startup message
	log.Info().
		Str("branch", branch).
		Str("revision", revision).
		Str("buildDate", buildDate).
		Str("goVersion", goVersion).
		Msg("Starting estafette-ci-db-migrator...")
}
