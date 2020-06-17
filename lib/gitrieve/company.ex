defmodule Gitrieve.Company do
    use Ecto.Schema

    import Ecto.Changeset

    schema "company" do
        field :location, :string
        field :org_name, :string
        field :public_repos, :integer
        field :url, :string
        field :repo_list, {:array, :string}
        field :repo_url, {:array, :string}
    end

    def changeset(struct, params \\ %{}) do
        struct
            |> cast(params, [:org_name, :location, :public_repos, :url, :repo_list, :repo_url])
            |> validate_required([:org_name], message: "not found, try again")
    end
end