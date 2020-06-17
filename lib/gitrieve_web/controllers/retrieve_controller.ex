defmodule GitrieveWeb.RetrieveController do
    use GitrieveWeb, :controller

    alias Github
    alias Gitrieve.Company
    alias Gitrieve.Repo

    def index(conn, _params) do
        company = Repo.all(Company)
        render(conn, "index.html", company: company)
    end

    def show(conn, %{"id" => company_id}) do
       company = Repo.get!(Company, company_id)
       render(conn, "show.html", company: company)
    end

    def new(conn, _params) do
        changeset = Company.changeset(%Company{}, %{})
        render(conn, "new.html", changeset: changeset)
    end

    def create(conn, %{"company" => company}) do
        changeset = Company.changeset(%Company{},
            Github.fetch_github(company["org_name"]))
        case Repo.insert(changeset) do
            {:ok, post} ->
                conn
                |> put_flash(:info, "Repositories has been retrieved")
                |> redirect(to: Routes.retrieve_path(conn, :index))
            {:error, changeset} ->
                render(conn, "new.html", changeset: changeset)
        end
        
    end
end