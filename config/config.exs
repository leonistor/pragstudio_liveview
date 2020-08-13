# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pragstudio,
  ecto_repos: [Pragstudio.Repo]

# Configures the endpoint
config :pragstudio, PragstudioWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "asw0A+YjshUFFj8tT+j1qs7zQU3wzu6Dbi5b+H6qOPCUchAUFvn9RnPab7a2wlqn",
  render_errors: [view: PragstudioWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Pragstudio.PubSub,
  live_view: [signing_salt: "J+bHXoko"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
