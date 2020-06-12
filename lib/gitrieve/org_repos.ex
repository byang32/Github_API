defmodule Gitrieve.OrgRepo do
     use Ecto.Schema

     import Ecto.Changeset

     schema "repos" do
        field :repo_name, :string
        field :repo_url, :string
     end

     def changeset(struct, params \\ %{}) do
         struct
            |> cast(params, [:repo_name, :repo_url])
     end
end