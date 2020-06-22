defmodule Github do

  def github_client, do: Tentacat.Client.new(%{access_token: "f82b26dc9a070045c7c9b9d0b5c422e6145c3331"})

  def fetch_github(org_name) do
    client = github_client()

    get_org(org_name) ++
    get_repos(org_name)
    |> Map.new()
  end

  def get_org(org_name) do
    client = github_client()
    # {200, data, _response} = Tentacat.Organizations.find(client, org_name)
    case Tentacat.Organizations.find(client, org_name) do
      {200, data, _response} ->
        all = fn :get, data, next -> Enum.map(data, next) end
        get_in(data, [all])

        [
          location: data["location"],
          org_name: data["name"],
          public_repos: data["public_repos"],
          url: data["html_url"]
        ]

      {404, data, _response} ->
        [error: get_in(data, ["message"])]
      end
  end

  def get_repos(org_name) do
    client = github_client()
    case Tentacat.Repositories.list_orgs(client, org_name) do
      {200, data, _response} ->
        all = fn :get, data, next -> Enum.map(data, next) end
        
        [
          repo_list: get_in(data, [all, "name"]), 
          repo_url: get_in(data, [all, "clone_url"])
        ]
        
      {404, data, _response} ->
        [error: get_in(data, ["message"])]
    end
  end
end