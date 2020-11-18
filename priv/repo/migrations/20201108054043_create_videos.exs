defmodule ScreenerLive.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""

    create table(:videos) do
      add :title, :string
      add :external_identifier, :string
      add :uuid, :uuid, null: false
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:videos, [:user_id])
  end

  def down do
    drop table(:videos)
  end
end
