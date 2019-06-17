defmodule ChallengeWeb.SessionsView do
  use ChallengeWeb, :view
  def render("show.json", auth_token) do
    %{id: auth_token.id, token: auth_token.token}
  end
end
