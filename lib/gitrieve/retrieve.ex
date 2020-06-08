defmodule Gitrieve.Retrieve do
    use Ecto.Schema

    import Ecto.Changeset

    schema "retrieve" do
        field :location, :string
        field :org_name, :string
        field :public_repos, :integer
        field :url, :string 
    end

    def changeset(struct, params \\ %{}) do
        struct
            |> cast(params, [:org_name, :location, :public_repos, :url])
            |> validate_required([:org_name])
    end
end