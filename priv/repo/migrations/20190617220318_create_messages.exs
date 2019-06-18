defmodule Challenge.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    MessageTypeEnum.create_type
    create table(:messages) do
      add :type, MessageTypeEnum.type()
      add :metadata, :map
      add :sender_id, references(:users, on_delete: :nothing)
      add :recipient_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:messages, [:sender_id])
    create index(:messages, [:recipient_id])
  end
end
