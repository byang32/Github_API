defmodule Gitrieve.Repo.Migrations.AddOrganization do
  use Ecto.Migration

  def change do
    create table("retrieve") do
      add :org_name, :string
      add :location, :string
      add :public_repos, :integer
      add :url, :string
    end
  end
end
