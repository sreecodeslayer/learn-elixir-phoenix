defmodule DiscussWeb.Plugs.RequireAuth do
  import Phoenix.Controller
  import Plug.Conn
  alias DiscussWeb.Router.Helpers, as: Routes

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()
    end
  end
end
