defmodule ChallengeWeb.SessionsControllerTest do
  use ChallengeWeb.ConnCase

  alias Challenge.{User, AuthToken, Repo}
  import Ecto.Query
  alias Plug.Test

  @create_attrs %{
    username: "some username",
    password: "some password"
  }
  @current_user_attrs %{
    username: "some current user username",
    password: "some current user password"
  }

  def fixture(:user) do
    {:ok, user} = User.create_user(@create_attrs)
    user
  end

  def fixture(:current_user) do
    {:ok, current_user} = User.create_user(@current_user_attrs)
    current_user
  end

  setup %{conn: conn} do
    {:ok, conn: conn, current_user: current_user} = setup_current_user(conn)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), current_user: current_user}
  end


  describe "login user" do
    test "renders user when user credentials are good", %{conn: conn, current_user: current_user} do
      conn =
        post(
          conn,
          sessions_path(conn, :create, %{
            username: current_user.username,
            password: @current_user_attrs.password
          })
        )

      auth_token = AuthToken |> last(:inserted_at) |> Repo.one

      assert json_response(conn, 200) == %{
               "id" => current_user.id, "token" => auth_token.token
             }
    end

    test "returns generic error when user doesn't exist", %{conn: conn} do
      conn =
        post(conn, sessions_path(conn, :create, %{username: "nonexistent username", password: ""}))

      assert response(conn, 401) == "Invalid user or password"
    end

    test "returns generic error when password is wrong", %{conn: conn, current_user: current_user} do
      conn =
        post(conn, sessions_path(conn, :create, %{username: current_user.username, password: "wrong"}))

      assert response(conn, 401) == "Invalid user or password"
    end
  end

  defp setup_current_user(conn) do
    current_user = fixture(:current_user)

    {:ok,
     conn: Test.init_test_session(conn, current_user_id: current_user.id),
     current_user: current_user}
  end
end
