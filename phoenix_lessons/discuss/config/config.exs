# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, DiscussWeb.Endpoint,
  url: [host: "localhost"],
  debug_errors: true,
  code_reloader: true,
  secret_key_base: "8GcbqehV7spXLFAc/TSOL67naYg2o/Ua73xVu76DvsnLU2d7ycSMZUlL+ZLwKgKh",
  render_errors: [view: DiscussWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :oauth2,
  serializers: %{"application/json" => Jason}

config :ueberauth, Ueberauth,
	providers: [
		github: {Ueberauth.Strategy.Github, []}
	]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
	client_id: System.get_env("GITHUB_CLIENT_ID"),
	client_secret: System.get_env("GITHUB_CLIENT_SECRET")