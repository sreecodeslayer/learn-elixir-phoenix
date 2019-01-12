defmodule DiscussWeb.AuthController do
	use DiscussWeb, :controller
	plug Ueberauth
	alias DiscussWeb.User

	def callback(conn, params) do
		%{assigns: %{ueberauth_auth: auth}} = conn
		%{"provider" => provider} = params
		user_parmas = %{
			token: auth.credentials.token,
			name: auth.info.name,
			email: auth.info.email,
			provider: provider
		}

		changeset = User.changeset(%User{},user_parmas)

		signin(conn,changeset)
	end

	defp insert_or_update(changeset) do
		case Repo.get_by(User, email: changeset.changes.email) do
			nil ->
				Repo.insert(changeset)
			user -> {:ok, user}
		end
	end

	defp signin(conn, changeset) do
		case insert_or_update(changeset) do
			{:ok, user} ->
				conn
				|> put_flash(:success, "Welcome back, #{user.email}")
				|> put_session(:user_id, user.id)
				|> redirect(to: Routes.topic_path(conn, :index))
			{:error, reason} ->
				conn
				|> put_flash(:error, "Something went wrong with login, #{reason}")
				|> redirect(to: Routes.topic_path(conn, :index))
		end
	end
end
