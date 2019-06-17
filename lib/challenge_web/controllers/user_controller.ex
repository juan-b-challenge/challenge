defmodule ChallengeWeb.UserController do
  use ChallengeWeb, :controller
  alias Challenge.User

  def create(conn, user_params) do
    case User.create_user(user_params) do
      {:ok, %User{} = user} ->
        conn
          |> put_status(:ok)
          |> render("show.json", %{user_id: user.id})

      {:error, error} ->
        conn
        |> send_resp(401, "Error")
    end
  end

end
