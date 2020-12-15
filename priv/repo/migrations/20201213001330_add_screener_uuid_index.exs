defmodule ScreenerLive.Repo.Migrations.AddScreenerToken do
  use Ecto.Migration

  def change do
    create unique_index(:screenings, :uuid)
  end
end
