use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :lyn, Lyn.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/webpack/bin/webpack.js",
                    "--watch-stdin", "--progress", "--colors"]]

# Watch static and templates for browser reloading.
config :lyn, Lyn.Endpoint,
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

if File.exists?("/usr/local/Cellar/postgresql/") do
  # Configure your database
  config :lyn, Lyn.Repo,
    adapter: Ecto.Adapters.Postgres,
    username: System.get_env("USER"),
    password: "",
    database: "lyn_dev",
    hostname: "localhost",
    pool_size: 10
else
  # Configure your database
  config :lyn, Lyn.Repo,
    adapter: Ecto.Adapters.Postgres,
    username: "postgres",
    password: "postgres",
    database: "lyn_dev",
    hostname: "localhost",
    pool_size: 10
end

# Configure dogma
config :dogma,
  rule_set: Dogma.RuleSet.All
