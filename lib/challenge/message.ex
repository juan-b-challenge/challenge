defmodule Challenge.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Challenge.{Message, Repo}

  schema "messages" do
    field :metadata, :map
    field :type, MessageTypeEnum
    field :sender_id, :id
    field :recipient_id, :id

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:type, :metadata, :sender_id, :recipient_id])
    |> validate_required([:type, :sender_id, :recipient_id, :metadata])
  end

  def create_message(attrs = %{"content" => %{"type" => "text", "text" => text}}) do
    attrs = attrs
      |> transform_common_attrs
      |> Map.put_new("metadata", %{"text" => text})

    perform_create_message(attrs)
  end

  def create_message(attrs = %{"content" => %{"type" => "image", "url" => url, "height" => height, "width" => width}}) do
    attrs = attrs
      |> transform_common_attrs
      |> Map.put_new("metadata", %{"url" => url, "height" => height, "width" => width})

    perform_create_message(attrs)
  end

  def create_message(attrs = %{"content" => %{"type" => "video", "url" => url, "source" => source}}) do
    case source do
      value when value in ["youtube", "vimeo"] ->
        attrs = attrs
          |> transform_common_attrs
          |> Map.put_new("metadata", %{"url" => url, "source" => source})

        perform_create_message(attrs)
      value ->
        {:error, "Invalid Source #{value}"}
    end
  end

  def create_message(_) do
    {:error, "Bad arguments"}
  end

  defp perform_create_message(attrs) do
    try do
      %Message{}
      |> Message.changeset(attrs)
      |> Repo.insert()
    rescue
      e in Ecto.ConstraintError ->
        {:error, "One of the users does not exist"}

      e in RuntimeError ->
        {:error, "An error occurred"}
    end
  end

  defp transform_common_attrs(attrs) do
    content = Map.get(attrs, "content")
    attrs
      |> Map.put_new("recipient_id", Map.get(attrs, "recipient"))
      |> Map.put_new("sender_id", Map.get(attrs, "sender"))
      |> Map.put_new("type", Map.get(content, "type"))
      |> Map.drop(["recipient", "sender"])
  end
end
