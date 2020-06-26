defmodule GitrieveWeb.AuthController do
    use GitrieveWeb, :controller

    alias Gitrieve.User
    alias Gitrieve.Repo
  
    plug Ueberauth

    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
      user_params = %{
        token: auth.credentials.token, 
        email: auth.info.email, 
        provider: to_string(auth.provider)
      }
      changeset = User.changeset(%User{}, user_params)

      signin(conn, changeset)
    end

    def signout(conn, _params) do
      conn
      |> configure_session(drop: true)
      |> redirect(to: Routes.lobby_path(conn, :index))
    end

    defp signin(conn, changeset) do
      case insert_or_update_user(changeset) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "Welcome Back!")
          |> put_session(:user_id, user.id)
          |> redirect(to: Routes.lobby_path(conn, :index))
        {:error, _reason} ->
          conn
          |> put_flash(:error, "Error signing in")
          |> redirect(to: Routes.lobby_path(conn, :index))
      end
    end

    defp insert_or_update_user(changeset) do
      case Repo.get_by(User, email: changeset.changes.email) do
        nil ->
          Repo.insert(changeset)
        user ->
          {:ok, user}
      end
    end
  end