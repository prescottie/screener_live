defmodule ScreenerLive.ScreeningsTest do
  use ScreenerLive.DataCase

  alias ScreenerLive.Screenings

  describe "videos" do
    alias ScreenerLive.Screenings.Video

    @valid_attrs %{external_identifier: "some external_identifier", title: "some title", uuid: "some uuid"}
    @update_attrs %{external_identifier: "some updated external_identifier", title: "some updated title", uuid: "some updated uuid"}
    @invalid_attrs %{external_identifier: nil, title: nil, uuid: nil}

    def video_fixture(attrs \\ %{}) do
      {:ok, video} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Screenings.create_video()

      video
    end

    test "list_videos/0 returns all videos" do
      video = video_fixture()
      assert Screenings.list_videos() == [video]
    end

    test "get_video!/1 returns the video with given id" do
      video = video_fixture()
      assert Screenings.get_video!(video.id) == video
    end

    test "create_video/1 with valid data creates a video" do
      assert {:ok, %Video{} = video} = Screenings.create_video(@valid_attrs)
      assert video.external_identifier == "some external_identifier"
      assert video.title == "some title"
      assert video.uuid == "some uuid"
    end

    test "create_video/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Screenings.create_video(@invalid_attrs)
    end

    test "update_video/2 with valid data updates the video" do
      video = video_fixture()
      assert {:ok, %Video{} = video} = Screenings.update_video(video, @update_attrs)
      assert video.external_identifier == "some updated external_identifier"
      assert video.title == "some updated title"
      assert video.uuid == "some updated uuid"
    end

    test "update_video/2 with invalid data returns error changeset" do
      video = video_fixture()
      assert {:error, %Ecto.Changeset{}} = Screenings.update_video(video, @invalid_attrs)
      assert video == Screenings.get_video!(video.id)
    end

    test "delete_video/1 deletes the video" do
      video = video_fixture()
      assert {:ok, %Video{}} = Screenings.delete_video(video)
      assert_raise Ecto.NoResultsError, fn -> Screenings.get_video!(video.id) end
    end

    test "change_video/1 returns a video changeset" do
      video = video_fixture()
      assert %Ecto.Changeset{} = Screenings.change_video(video)
    end
  end

  describe "screenings" do
    alias ScreenerLive.Screenings.Screening

    @valid_attrs %{recipient_email: "some recipient_email", screenings_amount: 42, screenings_expiry: ~N[2010-04-17 14:00:00], screenings_used: 42, uuid: "7488a646-e31f-11e4-aace-600308960662"}
    @update_attrs %{recipient_email: "some updated recipient_email", screenings_amount: 43, screenings_expiry: ~N[2011-05-18 15:01:01], screenings_used: 43, uuid: "7488a646-e31f-11e4-aace-600308960668"}
    @invalid_attrs %{recipient_email: nil, screenings_amount: nil, screenings_expiry: nil, screenings_used: nil, uuid: nil}

    def screening_fixture(attrs \\ %{}) do
      {:ok, screening} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Screenings.create_screening()

      screening
    end

    test "list_screenings/0 returns all screenings" do
      screening = screening_fixture()
      assert Screenings.list_screenings() == [screening]
    end

    test "get_screening!/1 returns the screening with given id" do
      screening = screening_fixture()
      assert Screenings.get_screening!(screening.id) == screening
    end

    test "create_screening/1 with valid data creates a screening" do
      assert {:ok, %Screening{} = screening} = Screenings.create_screening(@valid_attrs)
      assert screening.recipient_email == "some recipient_email"
      assert screening.screenings_amount == 42
      assert screening.screenings_expiry == ~N[2010-04-17 14:00:00]
      assert screening.screenings_used == 42
      assert screening.uuid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_screening/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Screenings.create_screening(@invalid_attrs)
    end

    test "update_screening/2 with valid data updates the screening" do
      screening = screening_fixture()
      assert {:ok, %Screening{} = screening} = Screenings.update_screening(screening, @update_attrs)
      assert screening.recipient_email == "some updated recipient_email"
      assert screening.screenings_amount == 43
      assert screening.screenings_expiry == ~N[2011-05-18 15:01:01]
      assert screening.screenings_used == 43
      assert screening.uuid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_screening/2 with invalid data returns error changeset" do
      screening = screening_fixture()
      assert {:error, %Ecto.Changeset{}} = Screenings.update_screening(screening, @invalid_attrs)
      assert screening == Screenings.get_screening!(screening.id)
    end

    test "delete_screening/1 deletes the screening" do
      screening = screening_fixture()
      assert {:ok, %Screening{}} = Screenings.delete_screening(screening)
      assert_raise Ecto.NoResultsError, fn -> Screenings.get_screening!(screening.id) end
    end

    test "change_screening/1 returns a screening changeset" do
      screening = screening_fixture()
      assert %Ecto.Changeset{} = Screenings.change_screening(screening)
    end
  end
end
