defmodule ChallengeWeb.MessageController do
  use ChallengeWeb, :controller
  alias Challenge.{Message, Repo}
  import Ecto.Query

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

  def get(conn, query_params) do
    limit = query_params["limit"] || "100"
    recipient_id = query_params["recipient"]
    start_id = query_params["start"]

    messages = Message
      |> where(recipient_id: ^recipient_id)
      |> where([m], m.id >= ^start_id)
      |> limit(^limit)
      |> Repo.all

    conn
      |> put_status(:ok)
      |> render("messages.json", messages: messages)
  end

end
