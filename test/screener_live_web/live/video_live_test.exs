defmodule ScreenerLiveWeb.VideoLiveTest do
  use ScreenerLiveWeb.ConnCase

  import Phoenix.LiveViewTest

  alias ScreenerLive.Screenings

  @create_attrs %{external_identifier: "some external_identifier", title: "some title", uuid: "some uuid"}
  @update_attrs %{external_identifier: "some updated external_identifier", title: "some updated title", uuid: "some updated uuid"}
  @invalid_attrs %{external_identifier: nil, title: nil, uuid: nil}

  defp fixture(:video) do
    {:ok, video} = Screenings.create_video(@create_attrs)
    video
  end

  defp create_video(_) do
    video = fixture(:video)
    %{video: video}
  end

  describe "Index" do
    setup [:create_video]

    test "lists all videos", %{conn: conn, video: video} do
      {:ok, _index_live, html} = live(conn, Routes.video_index_path(conn, :index))

      assert html =~ "Listing Videos"
      assert html =~ video.external_identifier
    end

    test "saves new video", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.video_index_path(conn, :index))

      assert index_live |> element("a[href=\"/videos/new\"]") |> render_click() =~
               "New Video"

      assert_patch(index_live, Routes.video_index_path(conn, :new))

      assert index_live
             |> form("#video-form", video: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#video-form", video: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.video_index_path(conn, :index))

      assert html =~ "Video created successfully"
      assert html =~ "some external_identifier"
    end

    test "updates video in listing", %{conn: conn, video: video} do
      {:ok, index_live, _html} = live(conn, Routes.video_index_path(conn, :index))

      assert index_live |> element("#video-#{video.id} a", "Edit") |> render_click() =~
               "Edit Video"

      assert_patch(index_live, Routes.video_index_path(conn, :edit, video))

      assert index_live
             |> form("#video-form", video: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#video-form", video: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.video_index_path(conn, :index))

      assert html =~ "Video updated successfully"
      assert html =~ "some updated external_identifier"
    end

    test "deletes video in listing", %{conn: conn, video: video} do
      {:ok, index_live, _html} = live(conn, Routes.video_index_path(conn, :index))

      assert index_live |> element("#video-#{video.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#video-#{video.id}")
    end
  end

  describe "Show" do
    setup [:create_video]

    test "displays video", %{conn: conn, video: video} do
      {:ok, _show_live, html} = live(conn, Routes.video_show_path(conn, :show, video))

      assert html =~ "Show Video"
      assert html =~ video.external_identifier
    end

    test "updates video within modal", %{conn: conn, video: video} do
      {:ok, show_live, _html} = live(conn, Routes.video_show_path(conn, :show, video))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Video"

      assert_patch(show_live, Routes.video_show_path(conn, :edit, video))

      assert show_live
             |> form("#video-form", video: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#video-form", video: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.video_show_path(conn, :show, video))

      assert html =~ "Video updated successfully"
      assert html =~ "some updated external_identifier"
    end
  end
end
