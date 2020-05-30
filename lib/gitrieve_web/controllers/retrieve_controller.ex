defmodule GitrieveWeb.RetrieveController do
    use GitrieveWeb, :controller

    alias Github
    alias Gitrieve.Retrieve
    alias Gitrieve.Repo

    def index(conn, _params) do
        retrieve = Repo.all(Retrieve)

        render conn, "index.html", retrieve: retrieve
    end

    def new(conn, params) do
        changeset = Retrieve.changeset(%Retrieve{}, %{})
        
        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"retrieve" => retrieve}) do
        changeset = Retrieve.changeset(%Retrieve{}, retrieve)
        
        case Repo.insert(changeset) do
            {:ok, post} ->
                conn
                |> put_flash(:info, "Repositories has been retrieved")
                |> redirect(to: Routes.retrieve_path(conn, :index))
            {:error, changeset} ->
                render conn, "new.html", changeset: changeset
        end
        
    end
end