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

# React server-side rendering config
config :lyn, :hot, if(Mix.env == :dev, do: :client, else: false)
config :lyn, :pool_size, if(Mix.env == :dev, do: 1, else: 8)
config :lyn, :pool_max_overflow, if(Mix.env == :dev, do: 5, else: 16)
config :lyn, :global_config, %{
  example_config: "Config In Env :global_config of app :lyn"
}

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
  base_path: "/auth",
  providers: [
    facebook: { Ueberauth.Strategy.Facebook, [] },
    github: { Ueberauth.Strategy.Github, [] },
    google: { Ueberauth.Strategy.Google, [] },
    identity: { Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"],
      uid_field: :username,
      nickname_field: :username,
    ] },
    slack: { Ueberauth.Strategy.Slack, [] },
    twitter: { Ueberauth.Strategy.Twitter, [] }
  ]

# Configure ueberauth_facebook
config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: System.get_env("FACEBOOK_CLIENT_ID"),
  client_secret: System.get_env("FACEBOOK_CLIENT_SECRET")

# Configure ueberauth_github
config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

# Configure ueberauth_google
config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
  redirect_uri: System.get_env("GOOGLE_REDIRECT_URI")

# Configure ueberauth_slack
config :ueberauth, Ueberauth.Strategy.Slack.OAuth,
  client_id: System.get_env("SLACK_CLIENT_ID"),
  client_secret: System.get_env("SLACK_CLIENT_SECRET")

# Configure ueberauth_twitter
config :ueberauth, Ueberauth.Strategy.Twitter.OAuth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET")

# Configure guardian
config :guardian, Guardian,
  issuer: "Lyn.#{Mix.env}",
  ttl: { 30, :days },
  verify_issuer: true,
  serializer: Lyn.GuardianSerializer,
  secret_key: to_string(Mix.env),
  hooks: GuardianDb,
  permissions: %{
    default: [
      :read_profile,
      :write_profile,
      :read_token,
      :revoke_token,
    ],
  }

# Configure guardian_db
config :guardian_db, GuardianDb,
       repo: Lyn.Repo
