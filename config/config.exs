# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

config :screener_live,
  ecto_repos: [ScreenerLive.Repo]

# Configures the endpoint
config :screener_live, ScreenerLiveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: ScreenerLiveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ScreenerLive.PubSub,
  live_view: [signing_salt: "q67p1k2W"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :waffle,
  # or Waffle.Storage.Local
  storage: Waffle.Storage.S3,
  # if using S3
  bucket: System.get_env("AWS_BUCKET_NAME")

# If using S3:
config :ex_aws,
  json_codec: Jason,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  region: System.get_env("AWS_REGION")

config :screener_live, ScreenerLive.Mailer,
  adapter: Bamboo.MandrillAdapter,
  api_key: "my_api_key"

config :kaffy,
  otp_app: :screener_live,
  ecto_repo: ScreenerLive.Repo,
  router: ScreenerLiveWeb.Router

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
