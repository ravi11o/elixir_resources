# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elixir_resources,
  ecto_repos: [ElixirResources.Repo]

# Configures the endpoint
config :elixir_resources, ElixirResources.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xd+zyVqw3XRwuTMiB28e6asOMcGldvI3dHTilnPpcvQYJdmtrIA8VrSxYS9nLpvZ",
  render_errors: [view: ElixirResources.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElixirResources.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
