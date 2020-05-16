defmodule GithubApi do

  def fetch_org(org) do
    github_client()
    
    org
    |> get_list_repo
    # |> get_org_repo
  end

  def github_client do
    Tentacat.Client.new(%{access_token: "86d15bcd57546ecf695fb9c790e69663d29698d0"})
  end

  def get_org_repo(org) do
    client = github_client()
    Tentacat.Organizations.find(client, org)
    
  end

  def get_list_repo(org) do
    client = github_client()
    Tentacat.Repositories.list_orgs(client, org)
  end

end