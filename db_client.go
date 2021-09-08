package main

import (
	"database/sql"
	"fmt"

	foundation "github.com/estafette/estafette-foundation"
	"github.com/pressly/goose"
	"github.com/rs/zerolog/log"

	// use postgres client library to connect to db
	_ "github.com/lib/pq"
)

// DBClient is the interface for communicating with DB
type DBClient interface {
	Connect() error
	ConnectWithDriverAndSource(string, string) error
	AwaitDatabaseReadiness() (err error)
	MigrateSchema() error
}

type dbClient struct {
	databaseDriver           string
	migrationsDir            string
	connectionString         string
	database                 string
	host                     string
	Insecure                 bool
	sslMode                  string
	certificateAuthorityPath string
	certificatePath          string
	certificateKeyPath       string
	port                     int
	user                     string
	password                 string
	databaseConnection       *sql.DB
}

// NewDBClient returns a new .DBClient
func NewDBClient(connectionString, database, host string, Insecure bool, sslMode, certificateAuthorityPath, certificatePath, certificateKeyPath string, port int, user, password string) DBClient {
	return &dbClient{
		databaseDriver:           "postgres",
		migrationsDir:            "/migrations",
		connectionString:         connectionString,
		database:                 database,
		host:                     host,
		Insecure:                 Insecure,
		sslMode:                  sslMode,
		certificatePath:          certificatePath,
		certificateKeyPath:       certificateKeyPath,
		certificateAuthorityPath: certificateAuthorityPath,
		port:                     port,
		user:                     user,
		password:                 password,
	}
}

// Connect sets up a connection with DB
func (c *dbClient) Connect() (err error) {

	dataSourceName := ""
	if c.connectionString != "" {
		log.Debug().Msgf("Connecting to database with connection string %v...", c.connectionString)
		dataSourceName = c.connectionString
	} else {
		log.Debug().Msgf("Connecting to database %v on host %v...", c.database, c.host)

		userAndpassword := c.user
		if c.password != "" {
			userAndpassword += ":" + c.password
		}

		if c.Insecure {
			dataSourceName = fmt.Sprintf("postgresql://%v@%v:%v/%v?sslmode=disable", userAndpassword, c.host, c.port, c.database)
		} else {
			dataSourceName = fmt.Sprintf("postgresql://%v@%v:%v/%v?sslmode=%v&sslrootcert=%v&sslcert=%v&sslkey=%v", userAndpassword, c.host, c.port, c.database, c.sslMode, c.certificateAuthorityPath, c.certificatePath, c.certificateKeyPath)
		}
	}

	return c.ConnectWithDriverAndSource(c.databaseDriver, dataSourceName)
}

// ConnectWithDriverAndSource set up a connection with any database
func (c *dbClient) ConnectWithDriverAndSource(driverName string, dataSourceName string) (err error) {

	c.databaseConnection, err = sql.Open(driverName, dataSourceName)
	if err != nil {
		return
	}

	return
}

func (c *dbClient) AwaitDatabaseReadiness() (err error) {
	return foundation.Retry(func() error {
		log.Info().Msg("Checking if database is ready...")
		return c.databaseConnection.Ping()
	}, foundation.Attempts(12), foundation.DelayMillisecond(5000), foundation.Fixed())
}

// MigrateSchema migrates the schema in DB
func (c *dbClient) MigrateSchema() (err error) {

	err = goose.SetDialect(c.databaseDriver)
	if err != nil {
		return err
	}

	err = goose.Status(c.databaseConnection, c.migrationsDir)
	if err != nil {
		return err
	}

	err = goose.Up(c.databaseConnection, c.migrationsDir)
	if err != nil {
		return err
	}

	return
}
