defmodule Gitrieve.Repo.Migrations.AddRepositories do
  use Ecto.Migration

  def change do
    create table("repos") do
      add :repo_name, :string
      add :repo_url, :string
    end
  end
end
