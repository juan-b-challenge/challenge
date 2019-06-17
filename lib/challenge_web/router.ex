defmodule ChallengeWeb.Router do
  use ChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  post "/login", ChallengeWeb.SessionsController, :create
  delete "/logout", ChallengeWeb.SessionsController, :delete

  scope "/api", ChallengeWeb do
    pipe_through :api
  end

  post "/check", ChallengeWeb.HealthController, :check

end
