defmodule Github do
  alias Gitrieve.Organization

  # def fetch_github(org_name) do
  #   client = github_client()
    
  #   get_org_repo(org_name) ++
  #   get_repo_name(org_name) ++
  #   get_repo_url(org_name) ++
  # end

  def github_client do
    Tentacat.Client.new(%{access_token: "c4a847cad1988bdf9454351c257efdf7460d7c50"})
  end

  def get_org(org_name) do
    client = github_client()
    {200, data, _response} = Tentacat.Organizations.find(client, org_name)

    all = fn :get, data, next -> Enum.map(data, next) end
    get_in(data, [all])
    |> Organization.new()
    %{ 
      location: data["location"],
      org_name: data["name"],
      public_repos: data["public_repos"],
      url: data["url"]
    }
    
  end

  def get_repo_name(org_name) do
    client = github_client()
    {200, data, _response} = Tentacat.Repositories.list_orgs(client, org_name)

    all = fn :get, data, next -> Enum.map(data, next) end
    get_in(data, [all, "name"])

  end

  def get_repo_url(org_name) do
    client = github_client()
    {200, data, _response} = Tentacat.Repositories.list_orgs(client, org_name)

    all = fn :get, data, next -> Enum.map(data, next) end
    get_in(data, [all, "clone_url"])

  end
end