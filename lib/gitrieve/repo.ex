defmodule Gitrieve.Repo do
  use Ecto.Repo,
    otp_app: :gitrieve,
    adapter: Ecto.Adapters.Postgres
end
