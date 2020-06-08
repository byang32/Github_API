defmodule GitrieveWeb.RetrieveController do
    use GitrieveWeb, :controller

    alias Github
    alias Gitrieve.Retrieve
    alias Gitrieve.Repo

    def index(conn, _params) do
        retrieve = Repo.all(Retrieve)
        
        render conn, "index.html", retrieve: retrieve
    end

    def show(conn, %{"retrieve" => retrieve}) do
        repos = Github.get_repo(retrieve["org_name"])
        urls = Github.get_url(retrieve["org_name"])

        render(conn, "show.html", repos: repos, urls: urls)
    end

    def new(conn, _params) do
        changeset = Retrieve.changeset(%Retrieve{}, %{})
       
        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"retrieve" => retrieve}) do
        changeset = Retrieve.changeset(%Retrieve{},
            Github.get_org(retrieve["org_name"]))
        
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