defmodule ChallengeWeb.UserView do
  use ChallengeWeb, :view

  def render("show.json", %{user_id: user_id}) do
    %{id: user_id}
  end
end
