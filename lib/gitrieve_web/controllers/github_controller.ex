defmodule GitrieveWeb.GithubController do
    use GitrieveWeb, :controller
    alias GitrieveWeb.Retrieve

    alias Github
    alias Gitrieve.Retrieve

    def search(conn, params) do
      Github.get_org_repo(Retrieve[:org_name])
    end
end