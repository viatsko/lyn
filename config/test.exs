use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lyn, Lyn.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

if File.exists?("/usr/local/Cellar/postgresql/") do
  # Configure your database
  config :lyn, Lyn.Repo,
    adapter: Ecto.Adapters.Postgres,
    username: System.get_env("USER"),
    password: "",
    database: "lyn_test",
    hostname: "localhost",
    pool: Ecto.Adapters.SQL.Sandbox
else
  # Configure your database
  config :lyn, Lyn.Repo,
    adapter: Ecto.Adapters.Postgres,
    username: "postgres",
    password: "postgres",
    database: "lyn_test",
    hostname: "localhost",
    pool: Ecto.Adapters.SQL.Sandbox
end
