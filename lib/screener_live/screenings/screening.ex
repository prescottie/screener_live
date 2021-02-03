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
    |> unique_constraint([:recipient_email,:video_id], name: :screenings_video_id_recipient_email_index)
  end

  def consumption_changeset(screening) do
    new_used_amount = screening.screenings_used + 1

    screening
    |> cast(%{"screenings_used" => new_used_amount}, [:screenings_used])
    |> validate_screenings_amount()
  end

  defp validate_screenings_amount(
         %Ecto.Changeset{valid?: true, changes: %{screenings_used: screenings_used}} = changeset
       ) do
    if screenings_used <= changeset.data.screenings_amount do
      changeset
    else
      add_error(
        changeset,
        :screenings_used,
        "This maximum number of screenings has already been consumed."
      )
    end
  end

  def expired?(screening) do
    screening.screenings_expiry < NaiveDateTime.utc_now()
  end

  def limit_reached?(screening) do
    screening.screenings_used >= screening.screenings_amount
  end

  def error_type(screening) do
    cond do
      screening == nil ->
        "not_found"

      expired?(screening) ->
        "expired"

      limit_reached?(screening) ->
        "limit_reached"

      true ->
        nil
    end
  end
end
