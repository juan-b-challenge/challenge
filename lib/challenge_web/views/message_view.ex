defmodule ChallengeWeb.MessageView do
  use ChallengeWeb, :view

  def render("show.json", %{message_id: message_id, timestamp: timestamp}) do
    %{id: message_id, timestamp: timestamp}
  end

  def render("messages.json", %{messages: messages}) do
    %{messages: render_many(messages, ChallengeWeb.MessageView, "message.json")}
  end

  def render("message.json", %{message: %{type: :text} = message}) do
    %{id: message.id,
      timestamp: message.inserted_at,
      sender: message.sender_id,
      recipient: message.recipient_id,
      content: %{type: "text", text: message.metadata["text"]}
    }
  end

  def render("message.json", %{message: %{type: :image} = message}) do
    %{id: message.id,
      timestamp: message.inserted_at,
      sender: message.sender_id,
      recipient: message.recipient_id,
      content: %{type: "image", width: message.metadata["width"], height: message.metadata["height"], url: message.metadata["url"]}
    }
  end

  def render("message.json", %{message: %{type: :video} = message}) do
    %{id: message.id,
      timestamp: message.inserted_at,
      sender: message.sender_id,
      recipient: message.recipient_id,
      content: %{type: "video", source: message.metadata["source"], url: message.metadata["url"]}
    }
  end

end
