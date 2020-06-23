defmodule GitrieveWeb.RetrieveController do
    use GitrieveWeb, :controller

    alias Github
    alias Gitrieve.Company
    alias Gitrieve.Repo

    def index(conn, params) do
        # company = Repo.all(Company)
        page = Company
                |> Repo.paginate(params) 
        render(conn, "index.html", company: page.entries, page: page)
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
            {:ok, _post} ->
                conn
                |> put_flash(:info, "Repositories has been retrieved")
                |> redirect(to: Routes.retrieve_path(conn, :index))
            {:error, changeset} ->
                render(conn, "new.html", changeset: changeset)
        end
    end

    def delete(conn, %{"id" => company_id}) do
        Repo.get!(Company, company_id)
        |> Repo.delete!

        conn
        |> put_flash(:info, "Repository Deleted")
        |> redirect(to: Routes.retrieve_path(conn, :index))
    end
end