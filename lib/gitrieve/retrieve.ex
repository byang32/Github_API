defmodule Gitrieve.Retrieve do
    use Ecto.Schema

    import Ecto.Changeset

    schema "retrieve" do
        field :org_name, :string
    end

    def changeset(struct, params \\ %{}) do
        struct
            |> cast(params, [:org_name])
            |> validate_required([:org_name])
    end
end