defmodule ScreenerLive.Repo do
  use Ecto.Repo,
    otp_app: :screener_live,
    adapter: Ecto.Adapters.Postgres
end
