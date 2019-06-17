defmodule Challenge.AuthToken do
  use Ecto.Schema
  import Ecto.Changeset
  alias Challenge.AuthToken

  schema "auth_tokens" do
    belongs_to :user, Challenge.User
    field :revoked, :boolean, default: false
    field :revoked_at, :utc_datetime
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(%AuthToken{} = auth_token, attrs) do
    auth_token
    |> cast(attrs, [:token, :revoked, :revoked_at])
    |> validate_required([:token])
    |> unique_constraint(:token)
  end
end
