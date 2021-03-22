package main

import (
	"database/sql"
	"fmt"

	"github.com/pressly/goose"
	"github.com/rs/zerolog/log"

	// use postgres client library to connect to cockroachdb
	_ "github.com/lib/pq"
)

// DBClient is the interface for communicating with CockroachDB
type DBClient interface {
	Connect() error
	ConnectWithDriverAndSource(string, string) error
	MigrateSchema() error
}

type cockroachDBClientImpl struct {
	databaseDriver            string
	migrationsDir             string
	cockroachConnectionString string
	cockroachDatabase         string
	cockroachHost             string
	cockroachInsecure         bool
	sslMode                   string
	cockroachCertificateDir   string
	certificateAuthorityPath  string
	cockroachPort             int
	cockroachUser             string
	cockroachPassword         string
	databaseConnection        *sql.DB
}

// NewCockroachDBClient returns a new cockroach.DBClient
func NewCockroachDBClient(cockroachConnectionString, cockroachDatabase, cockroachHost string, cockroachInsecure bool, sslMode, cockroachCertificateDir, certificateAuthorityPath string, cockroachPort int, cockroachUser, cockroachPassword string) (cockroachDBClient DBClient) {

	cockroachDBClient = &cockroachDBClientImpl{
		databaseDriver:            "postgres",
		migrationsDir:             "/migrations",
		cockroachConnectionString: cockroachConnectionString,
		cockroachDatabase:         cockroachDatabase,
		cockroachHost:             cockroachHost,
		cockroachInsecure:         cockroachInsecure,
		sslMode:                   sslMode,
		cockroachCertificateDir:   cockroachCertificateDir,
		certificateAuthorityPath:  certificateAuthorityPath,
		cockroachPort:             cockroachPort,
		cockroachUser:             cockroachUser,
		cockroachPassword:         cockroachPassword,
	}

	return
}

// Connect sets up a connection with CockroachDB
func (dbc *cockroachDBClientImpl) Connect() (err error) {

	dataSourceName := ""
	if dbc.cockroachConnectionString != "" {
		log.Debug().Msgf("Connecting to database with connection string %v...", dbc.cockroachConnectionString)
		dataSourceName = dbc.cockroachConnectionString
	} else {
		log.Debug().Msgf("Connecting to database %v on host %v...", dbc.cockroachDatabase, dbc.cockroachHost)

		userAndPassword := dbc.cockroachUser
		if dbc.cockroachPassword != "" {
			userAndPassword += ":" + dbc.cockroachPassword
		}

		if dbc.cockroachInsecure {
			dataSourceName = fmt.Sprintf("postgresql://%v@%v:%v/%v?sslmode=disable", userAndPassword, dbc.cockroachHost, dbc.cockroachPort, dbc.cockroachDatabase)
		} else {
			dataSourceName = fmt.Sprintf("postgresql://%v@%v:%v/%v?sslmode=%v&sslrootcert=%v&sslcert=%v/cert&sslkey=%v/key", userAndPassword, dbc.cockroachHost, dbc.cockroachPort, dbc.cockroachDatabase, dbc.sslMode, dbc.certificateAuthorityPath, dbc.cockroachCertificateDir, dbc.cockroachCertificateDir)
		}
	}

	return dbc.ConnectWithDriverAndSource(dbc.databaseDriver, dataSourceName)
}

// ConnectWithDriverAndSource set up a connection with any database
func (dbc *cockroachDBClientImpl) ConnectWithDriverAndSource(driverName string, dataSourceName string) (err error) {

	dbc.databaseConnection, err = sql.Open(driverName, dataSourceName)
	if err != nil {
		return
	}

	return
}

// MigrateSchema migrates the schema in CockroachDB
func (dbc *cockroachDBClientImpl) MigrateSchema() (err error) {

	err = goose.SetDialect(dbc.databaseDriver)
	if err != nil {
		return err
	}

	err = goose.Status(dbc.databaseConnection, dbc.migrationsDir)
	if err != nil {
		return err
	}

	err = goose.Up(dbc.databaseConnection, dbc.migrationsDir)
	if err != nil {
		return err
	}

	return
}
