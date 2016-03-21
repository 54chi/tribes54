use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tribes54, Tribes54.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tribes54, Tribes54.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres_db",
  password: "postgres_db",
  database: "tribes54_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
