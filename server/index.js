const keys = require('./keys');

// Express App Setup
// Define and set up express side of the application
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

// Create a new Express application.
const app = express();

// Allows us to make requests from multiple domains/ports.
// bodyParser helps turn body of POST request into a JSON value that
// Express API can work with.
app.use(cors());
app.use(bodyParser());

// Postgres Client Setup
const { Pool } = require('pg');
const pgClient = new Pool({
  user: keys.pgUser,
  host: keys.pgHost,
  database: keys.pgDatabase,
  password: keys.pgPassword,
  port: keys.pgPort
});

// Error listener
pgClient.on('error', () => console.log('Lost PG connection'));

// Create new table with single column titled values.
pgClient
  .query('CREATE TABLE IF NOT EXISTS values (number INT)')
  .catch(err => console.log(err));
