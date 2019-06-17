defmodule ChallengeWeb.HealthController do
  use ChallengeWeb, :controller

  def check(conn, _params) do
    json(conn, %{health: "ok"})
  end
end
