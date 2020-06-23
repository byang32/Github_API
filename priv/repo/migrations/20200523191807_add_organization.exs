defmodule Gitrieve.Repo.Migrations.AddOrganization do
  use Ecto.Migration

  def change do
    create table("company") do
      add :org_name, :string
      add :location, :string
      add :public_repos, :integer
      add :url, :string
      add :repo_list, {:array, :string}
      add :repo_url, {:array, :string}
      add :avatar_url, :string
    end
  end
end
