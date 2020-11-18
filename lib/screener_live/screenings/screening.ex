defmodule ScreenerLive.Screenings.Screening do
  use Ecto.Schema
  import Ecto.Changeset

  alias ScreenerLive.Screenings.Video

  schema "screenings" do
    field :recipient_email, :string
    field :screenings_amount, :integer
    field :screenings_expiry, :naive_datetime
    field :screenings_used, :integer
    field :uuid, Ecto.UUID, autogenerate: true

    timestamps()

    belongs_to :video, Video
    has_one :video_user, through: [:video, :user]
  end

  @doc false
  def changeset(screening, attrs) do
    screening
    |> cast(attrs, [
      :recipient_email,
      :screenings_amount,
      :screenings_used,
      :screenings_expiry
    ])
    |> validate_required([
      :recipient_email,
      :screenings_amount,
      :screenings_used,
      :screenings_expiry,
      :uuid
    ])
    |> unique_constraint(:video_id_recipient_email)
  end
end
