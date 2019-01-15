defmodule DiscussWeb.Plugs.SetUser do
  # for assign on conn
  import Plug.Conn
  # for session
  import Phoenix.Controller
  # DB operations
  alias Discuss.Repo
  # User model
  alias DiscussWeb.User

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)

      true ->
        assign(conn, :user, nil)
    end
  end
end
