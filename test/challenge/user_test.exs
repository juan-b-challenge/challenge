defmodule Challenge.UserTest do
  use Challenge.DataCase

  alias Challenge.User
  alias Challenge.AuthToken

  describe "users" do

    @valid_attrs %{username: "some username", is_active: true, password: "some password"}

    def create_user(attrs \\ %{}) do
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
    end

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> create_user()

      user
    end

    test "sign_in returns the user id and a token" do
      user = user_fixture()
      {:ok, %{id: id, token: token}} = User.sign_in(user.username, user.password)

      auth_token = AuthToken |> last(:inserted_at) |> Repo.one

      assert id == user.id
      assert token == auth_token.token
    end

    test "sign_in returns generic error with wrong username" do
      user = user_fixture()
      {:error, "Invalid user or password"} = User.sign_in("otherUser", user.password)
    end

    test "sign_in returns generic error with wrong password" do
      user = user_fixture()
      {:error, "Invalid user or password"} = User.sign_in(user.username, "wrong")
    end

  end
end
