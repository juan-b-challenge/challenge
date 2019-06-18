defmodule ChallengeWeb.Router do
  use ChallengeWeb, :router

  pipeline :authenticate do
    plug ChallengeWeb.Plugs.Authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  post "/login", ChallengeWeb.SessionsController, :create
  delete "/logout", ChallengeWeb.SessionsController, :delete

  scope "/api", ChallengeWeb do
    pipe_through :api
  end

  scope "/messages", ChallengeWeb do
    pipe_through :authenticate
    post "/check", HealthController, :check
    post "/", MessageController, :create
    get "/", MessageController, :get
  end

  post "/users", ChallengeWeb.UserController, :create

  post "/check", ChallengeWeb.HealthController, :check

end
