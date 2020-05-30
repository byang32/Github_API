defmodule Github do

  # def fetch_github(org) do
  #   github_client()
    
  #   get_org_repo(org) ++
  #   get_repo_name(org) ++
  #   get_repo_url(org)
  # end

  def github_client do
    Tentacat.Client.new
  end

  def get_org_repo(org) do
    client = github_client()
    {200, data, _response} = Tentacat.Organizations.find(client, org)

    all = fn :get, data, next -> Enum.map(data, next) end
    get_in(data, [all])
      
    %{ 
      name: data["name"], 
      location: data["location"], 
      github_url: data["url"], 
      public_repos: data["public_repos"]
    }
  end

  def get_repo_name(org) do
    client = github_client()
    {200, data, _response} = Tentacat.Repositories.list_orgs(client, org)

    all = fn :get, data, next -> Enum.map(data, next) end
    get_in(data, [all, "name"])
  end

  def get_repo_url(org) do
    client = github_client()
    {200, data, _response} = Tentacat.Repositories.list_orgs(client, org)

    all = fn :get, data, next -> Enum.map(data, next) end
    get_in(data, [all, "clone_url"])
  end
end