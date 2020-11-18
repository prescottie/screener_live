defmodule ScreenerLive.Screenings.Video do
  use Ecto.Schema
  import Ecto.Changeset

  alias ScreenerLive.Screenings.Screening
  alias ScreenerLive.Accounts.User

  schema "videos" do
    field :external_identifier, :string
    field :title, :string
    field :uuid, Ecto.UUID, autogenerate: true

    timestamps()

    belongs_to :user, User
    has_many :screenings, Screening
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:title, :external_identifier, :user_id])
    |> validate_required([:title, :external_identifier, :user_id])
  end
end
