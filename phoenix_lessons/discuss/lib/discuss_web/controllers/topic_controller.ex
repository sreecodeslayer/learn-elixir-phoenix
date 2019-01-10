defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias DiscussWeb.Topic

  def new(conn, params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    IO.puts(topic)
  end
end
