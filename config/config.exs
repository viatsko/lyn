# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :lyn, Lyn.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "9KVTn2e/gEOyRdPfJGBzxAaJwwuxwFKTEr+1U+DI/WTWwa+l6oO9SF49ZGkZKttO",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Lyn.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

# Configure ueberauth
config :ueberauth, Ueberauth,
  providers: [
    facebook: { Ueberauth.Strategy.Facebook, [ opt1: "value", opts2: "value" ] },
    github: { Ueberauth.Strategy.Github, [ opt1: "value", opts2: "value" ] }
  ]
