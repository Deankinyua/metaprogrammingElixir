defmodule Metaprograming.Repo do
  use Ecto.Repo,
    otp_app: :metaprograming,
    adapter: Ecto.Adapters.Postgres
end
