defmodule ChallengeWeb.MessageController do
  use ChallengeWeb, :controller
  alias Challenge.Message

  def create(conn, message_params) do
    case Message.create_message(message_params) do
      {:ok, %Message{} = message} ->
        conn
          |> put_status(:ok)
          |> render("show.json", %{message_id: message.id, timestamp: message.inserted_at})

      {:error, error} ->
        conn
        |> send_resp(401, "Error: #{error}")
    end
  end

end
