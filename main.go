package main

import (
	"runtime"
	"time"

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
	database                 = kingpin.Flag("database", "Database name.").Default("defaultdb").OverrideDefaultFromEnvar("DATABASE").String()
	host                     = kingpin.Flag("host", "Database host.").Default("estafette-ci-db-public").OverrideDefaultFromEnvar("HOST").String()
	insecure                 = kingpin.Flag("insecure", "Insecure connection.").Default("false").OverrideDefaultFromEnvar("INSECURE").Bool()
	port                     = kingpin.Flag("port", "Database port.").Default("26257").OverrideDefaultFromEnvar("PORT").Int()
	user                     = kingpin.Flag("user", "Database user.").Default("root").OverrideDefaultFromEnvar("USER").String()
	password                 = kingpin.Flag("password", "Database password.").Envar("PASSWORD").String()
	connectionString         = kingpin.Flag("connection-string", "Database connection string.").Envar("CONNECTION_STRING").String()
	sslMode                  = kingpin.Flag("ssl-mode", "SSL Mode used to connect to database.").Default("verify-full").OverrideDefaultFromEnvar("SSL_MODE").String()
	certificateAuthorityPath = kingpin.Flag("ssl-ca-path", "Path to certificate authority (CA) public certificate.").Default("/cockroach-certs/ca.crt").OverrideDefaultFromEnvar("SSL_CA_PATH").String()
	certificatePath          = kingpin.Flag("ssl-cert-path", "Path to public certificate.").Default("/cockroach-certs/tls.crt").OverrideDefaultFromEnvar("SSL_CERT_PATH").String()
	certificateKeyPath       = kingpin.Flag("ssl-key-path", "Path to certificate key.").Default("/cockroach-certs/tls.key").OverrideDefaultFromEnvar("SSL_KEY_PATH").String()
	waitSeconds              = kingpin.Flag("wait-seconds", "Seconds to wait before executin.").Default("0").OverrideDefaultFromEnvar("WAIT_SECONDS").Int()
)

func main() {
	// parse command line parameters
	kingpin.Parse()

	// init log format from envvar ESTAFETTE_LOG_FORMAT
	foundation.InitLoggingFromEnv(foundation.NewApplicationInfo(appgroup, app, version, branch, revision, buildDate))

	if *waitSeconds > 0 {
		log.Info().Msgf("Waiting for %v seconds before executing migration...", *waitSeconds)
		time.Sleep(time.Duration(*waitSeconds) * time.Second)
	}

	// set up database and update schema
	dbClient := NewDBClient(*connectionString, *database, *host, *insecure, *sslMode, *certificateAuthorityPath, *certificatePath, *certificateKeyPath, *port, *user, *password)

	err := dbClient.Connect()
	if err != nil {
		log.Warn().Err(err).Msg("Failed connecting to database")
	}

	err = dbClient.AwaitDatabaseReadiness()
	if err != nil {
		log.Warn().Err(err).Msg("Failed due database not being ready")
	}

	err = dbClient.MigrateSchema()
	if err != nil {
		log.Fatal().Err(err).Msg("Failed migrating database schema")
	}

	log.Info().Msg("Successfully migrated database schema")
}
