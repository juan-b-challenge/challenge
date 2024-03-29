# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :challenge,
  ecto_repos: [Challenge.Repo]

# Configures the endpoint
config :challenge, ChallengeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2msYq8e7I6lN5W+2MUgJYg7oBz+GXJPUd/SnR5zcpDZKnCrZapN7xFV8JwJN0eF/",
  render_errors: [view: ChallengeWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Challenge.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
