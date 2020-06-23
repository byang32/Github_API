defmodule Gitrieve.Repo do
  use Ecto.Repo,
    otp_app: :gitrieve,
    adapter: Ecto.Adapters.Postgres
  use Scrivener, page_size: 5
end
