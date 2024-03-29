use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :challenge, ChallengeWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :bcrypt_elixir, :log_rounds, 4

# Configure your database
config :challenge, Challenge.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "root",
  password: "",
  database: "challenge_test",
  hostname: System.get_env("DATABASE_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
