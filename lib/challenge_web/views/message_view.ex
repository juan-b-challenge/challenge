defmodule ChallengeWeb.MessageView do
  use ChallengeWeb, :view

  def render("show.json", %{message_id: message_id, timestamp: timestamp}) do
    %{id: message_id, timestamp: timestamp}
  end
end
