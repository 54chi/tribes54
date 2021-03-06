use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :tribes54, Tribes54.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin"]]

# Watch static and templates for browser reloading.
config :tribes54, Tribes54.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :tribes54, Tribes54.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres_db",
  password: "postgres_db",
  database: "tribes54_dev",
  hostname: "localhost",
  pool_size: 10

config :tribes54, Google,
  client_id: String.rstrip(System.get_env("GOOGLE_CLIENT_ID")),
  client_secret:  String.rstrip(System.get_env("GOOGLE_CLIENT_SECRET")),
  redirect_uri:  String.rstrip(System.get_env("GOOGLE_REDIRECT_URI"))
