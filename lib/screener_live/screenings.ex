defmodule ScreenerLive.Screenings do
  @moduledoc """
  The Screenings context.
  """

  import Ecto.Query, warn: false
  alias ScreenerLive.Repo

  alias ScreenerLive.Screenings.Video
  alias ScreenerLive.Screenings.Screening

  @doc """
  Returns the list of videos.

  ## Examples

      iex> list_videos()
      [%Video{}, ...]

  """
  def list_videos do
    Repo.all(Video)
  end

  def list_videos_by_user_id(user_id) do
    q =
      from v in Video,
        where: v.user_id == ^user_id,
        left_join: screenings in assoc(v, :screenings),
        preload: :screenings

    Repo.all(q)
  end

  @doc """
  Gets a single video.

  Raises `Ecto.NoResultsError` if the Video does not exist.

  ## Examples

      iex> get_video!(123)
      %Video{}

      iex> get_video!(456)
      ** (Ecto.NoResultsError)

  """
  def get_video!(id), do: Repo.get!(Video, id)

  @doc """
  Creates a video.

  ## Examples

      iex> create_video(%{field: value})
      {:ok, %Video{}}

      iex> create_video(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_video(attrs \\ %{}) do
    %Video{}
    |> Video.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a video.

  ## Examples

      iex> update_video(video, %{field: new_value})
      {:ok, %Video{}}

      iex> update_video(video, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_video(%Video{} = video, attrs) do
    video
    |> Video.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a video.

  ## Examples

      iex> delete_video(video)
      {:ok, %Video{}}

      iex> delete_video(video)
      {:error, %Ecto.Changeset{}}

  """
  def delete_video(%Video{} = video) do
    Repo.delete(video)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking video changes.

  ## Examples

      iex> change_video(video)
      %Ecto.Changeset{data: %Video{}}

  """
  def change_video(%Video{} = video, attrs \\ %{}) do
    Video.changeset(video, attrs)
  end

  @doc """
  Returns the list of screenings.

  ## Examples

      iex> list_screenings()
      [%Screening{}, ...]

  """
  def list_screenings do
    Repo.all(Screening)
  end

  @doc """
  Gets a single screening.

  Raises `Ecto.NoResultsError` if the Screening does not exist.

  ## Examples

      iex> get_screening!(123)
      %Screening{}

      iex> get_screening!(456)
      ** (Ecto.NoResultsError)

  """
  def get_screening!(id), do: Repo.get!(Screening, id)

  @doc """
  Creates a screening.

  ## Examples

      iex> create_screening(%{field: value})
      {:ok, %Screening{}}

      iex> create_screening(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_screening(attrs \\ %{}) do
    %Screening{}
    |> Screening.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a screening.

  ## Examples

      iex> update_screening(screening, %{field: new_value})
      {:ok, %Screening{}}

      iex> update_screening(screening, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_screening(%Screening{} = screening, attrs) do
    screening
    |> Screening.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a screening.

  ## Examples

      iex> delete_screening(screening)
      {:ok, %Screening{}}

      iex> delete_screening(screening)
      {:error, %Ecto.Changeset{}}

  """
  def delete_screening(%Screening{} = screening) do
    Repo.delete(screening)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking screening changes.

  ## Examples

      iex> change_screening(screening)
      %Ecto.Changeset{data: %Screening{}}

  """
  def change_screening(%Screening{} = screening, attrs \\ %{}) do
    Screening.changeset(screening, attrs)
  end
end
