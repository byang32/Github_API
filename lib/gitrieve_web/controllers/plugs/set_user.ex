defmodule GitrieveWeb.Plugs.SetUser do
    import Plug.Conn
    import Phoenix.Controller

    alias Gitrieve.Repo
    alias Gitrieve.Users

    def init(_params) do
        
    end

    def call(conn, _params) do
        user_id = get_session(conn, :user_id)
        
        cond do
            user = user_id && Repo.get(User, user_id) ->
                assign(conn, :current_user, user) 
            true ->
               assign(conn, :current_user, nil)
        end
    end
end

