defmodule ScreenerLive.Screenings.Screening do
  use Ecto.Schema
  import Ecto.Changeset

  alias ScreenerLive.Screenings.Video

  schema "screenings" do
    field :recipient_email, :string
    field :screenings_amount, :integer
    field :screenings_expiry, :naive_datetime
    field :screenings_used, :integer, default: 0
    field :uuid, Ecto.UUID, autogenerate: true

    timestamps()

    belongs_to :video, Video
    has_one :user, through: [:video, :user]
  end

  @doc false
  def changeset(screening, attrs) do
    screening
    |> cast(attrs, [
      :recipient_email,
      :screenings_amount,
      :screenings_expiry,
      :video_id
    ])
    |> validate_required([
      :recipient_email,
      :screenings_amount,
      :screenings_expiry,
      :video_id
    ])
    |> unique_constraint(:video_id_recipient_email)
  end
end
