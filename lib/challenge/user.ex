defmodule Challenge.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Challenge.Repo
  alias Challenge.User
  alias Challenge.Services.Authenticator
  alias Challenge.AuthToken

  schema "users" do
    has_many :auth_tokens, AuthToken
    field :username, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    timestamps()
  end


  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> unique_constraint(:username, downcase: true)
    |> put_password_hash()
  end

  def sign_in(username, password) do
    case Comeonin.Bcrypt.check_pass(Repo.get_by(User, username: username), password) do
      {:ok, user} ->
        token = Authenticator.generate_token(user)
        Repo.insert(Ecto.build_assoc(user, :auth_tokens, %{token: token}))
        {:ok, %{id: user.id, token: token}}

      {:error, value} when value in ["invalid user-identifier", "invalid password"] -> {:error, "Invalid user or password"}
      err -> err
    end
  end

  def sign_out(conn) do
    case Authenticator.get_auth_token(conn) do
      {:ok, token} ->
        case Repo.get_by(AuthToken, %{token: token}) do
          nil -> {:error, :not_found}
          auth_token -> Repo.delete(auth_token)
        end
      error -> error
    end
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
