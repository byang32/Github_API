defmodule GithubApi do

  def fetch_org(org) do
    github_client()
    
    get_repo_list(org) &&
    get_org_repo(org)
  end

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

  def get_repo_list(org) do
    client = github_client()
    {200, data, _response} = Tentacat.Repositories.list_orgs(client, org)

    all = fn :get, data, next -> Enum.map(data, next) end

    get_in(data, [all, "name"])
    
  end
end