defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  alias DiscussWeb.{Topic, Comment}

  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Repo.get(Topic, topic_id)
    {:ok, %{}, assign(socket, :topic, topic)}
  end

  def handle_in(event, %{"text" => text}, socket) do
    changeset =
      socket.assigns.topic
      |> build_assoc(:comments)
      |> Comment.changeset(%{text: text})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        {:reply, :ok, socket}

      {:error, reason} ->
        {:reply, {:error, %{errors: changeset}, socket}}
    end

    {:reply, :ok, socket}
  end
end
