defmodule ScreenerLive.Repo.Migrations.CreateScreenings do
  use Ecto.Migration

  def change do
    create table(:screenings) do
      add :recipient_email, :string
      add :screenings_amount, :integer
      add :screenings_used, :integer
      add :screenings_expiry, :naive_datetime
      add :uuid, :uuid
      add :video_id, references(:videos, on_delete: :delete_all)

      timestamps()
    end

    create index(:screenings, [:video_id, :recipient_email], unique: true)
    create index(:screenings, [:video_id])
  end
end
