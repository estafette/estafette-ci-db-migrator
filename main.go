package main

import (
	stdlog "log"
	"os"
	"os/signal"
	"runtime"
	"sync"
	"syscall"

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
	cockroachDatabase       = kingpin.Flag("cockroach-database", "CockroachDB database.").Envar("COCKROACH_DATABASE").String()
	cockroachHost           = kingpin.Flag("cockroach-host", "CockroachDB host.").Envar("COCKROACH_HOST").String()
	cockroachInsecure       = kingpin.Flag("cockroach-insecure", "CockroachDB insecure connection.").Envar("COCKROACH_INSECURE").Bool()
	cockroachCertificateDir = kingpin.Flag("cockroach-certs-dir", "CockroachDB certificate directory.").Envar("COCKROACH_CERTS_DIR").String()
	cockroachPort           = kingpin.Flag("cockroach-port", "CockroachDB port.").Envar("COCKROACH_PORT").Int()
	cockroachUser           = kingpin.Flag("cockroach-user", "CockroachDB user.").Envar("COCKROACH_USER").String()
	cockroachPassword       = kingpin.Flag("cockroach-password", "CockroachDB password.").Envar("COCKROACH_PASSWORD").String()
)

func main() {

	// parse command line parameters
	kingpin.Parse()

	// configure json logging
	initLogging()

	// define channels and waitgroup to gracefully shutdown the application
	sigs := make(chan os.Signal, 1)                                    // Create channel to receive OS signals
	stop := make(chan struct{})                                        // Create channel to receive stop signal
	signal.Notify(sigs, os.Interrupt, syscall.SIGTERM, syscall.SIGINT) // Register the sigs channel to receieve SIGTERM
	wg := &sync.WaitGroup{}                                            // Goroutines can add themselves to this to be waited on so that they finish

	// set up database and update schema
	cockroachDBClient := NewCockroachDBClient(*cockroachDatabase, *cockroachHost, *cockroachInsecure, *cockroachCertificateDir, *cockroachPort, *cockroachUser, *cockroachPassword)
	err := cockroachDBClient.Connect()
	if err != nil {
		log.Warn().Err(err).Msg("Failed connecting to CockroachDB")
	}
	err = cockroachDBClient.MigrateSchema()
	if err != nil {
		log.Warn().Err(err).Msg("Failed migrating schema of CockroachDB")
	}

	// wait for graceful shutdown to finish
	<-sigs // Wait for signals (this hangs until a signal arrives)
	log.Debug().Msg("Shutting down...")

	log.Debug().Msg("Stopping goroutines...")
	close(stop) // Tell goroutines to stop themselves

	log.Debug().Msg("Awaiting waitgroup...")
	wg.Wait() // Wait for all to be stopped

	log.Info().Msg("Server gracefully stopped")
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