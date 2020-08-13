defmodule Pragstudio.Repo do
  use Ecto.Repo,
    otp_app: :pragstudio,
    adapter: Ecto.Adapters.Postgres
end
