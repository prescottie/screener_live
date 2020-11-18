defmodule ScreenerLiveWeb.ScreeningLiveTest do
  use ScreenerLiveWeb.ConnCase

  import Phoenix.LiveViewTest

  alias ScreenerLive.Screenings

  @create_attrs %{recipient_email: "some recipient_email", screenings_amount: 42, screenings_expiry: ~N[2010-04-17 14:00:00], screenings_used: 42, uuid: "7488a646-e31f-11e4-aace-600308960662"}
  @update_attrs %{recipient_email: "some updated recipient_email", screenings_amount: 43, screenings_expiry: ~N[2011-05-18 15:01:01], screenings_used: 43, uuid: "7488a646-e31f-11e4-aace-600308960668"}
  @invalid_attrs %{recipient_email: nil, screenings_amount: nil, screenings_expiry: nil, screenings_used: nil, uuid: nil}

  defp fixture(:screening) do
    {:ok, screening} = Screenings.create_screening(@create_attrs)
    screening
  end

  defp create_screening(_) do
    screening = fixture(:screening)
    %{screening: screening}
  end

  describe "Index" do
    setup [:create_screening]

    test "lists all screenings", %{conn: conn, screening: screening} do
      {:ok, _index_live, html} = live(conn, Routes.screening_index_path(conn, :index))

      assert html =~ "Listing Screenings"
      assert html =~ screening.recipient_email
    end

    test "saves new screening", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.screening_index_path(conn, :index))

      assert index_live |> element("a[href=\"/screenings/new\"]") |> render_click() =~
               "New Screening"

      assert_patch(index_live, Routes.screening_index_path(conn, :new))

      assert index_live
             |> form("#screening-form", screening: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#screening-form", screening: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.screening_index_path(conn, :index))

      assert html =~ "Screening created successfully"
      assert html =~ "some recipient_email"
    end

    test "updates screening in listing", %{conn: conn, screening: screening} do
      {:ok, index_live, _html} = live(conn, Routes.screening_index_path(conn, :index))

      assert index_live |> element("#screening-#{screening.id} a", "Edit") |> render_click() =~
               "Edit Screening"

      assert_patch(index_live, Routes.screening_index_path(conn, :edit, screening))

      assert index_live
             |> form("#screening-form", screening: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#screening-form", screening: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.screening_index_path(conn, :index))

      assert html =~ "Screening updated successfully"
      assert html =~ "some updated recipient_email"
    end

    test "deletes screening in listing", %{conn: conn, screening: screening} do
      {:ok, index_live, _html} = live(conn, Routes.screening_index_path(conn, :index))

      assert index_live |> element("#screening-#{screening.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#screening-#{screening.id}")
    end
  end

  describe "Show" do
    setup [:create_screening]

    test "displays screening", %{conn: conn, screening: screening} do
      {:ok, _show_live, html} = live(conn, Routes.screening_show_path(conn, :show, screening))

      assert html =~ "Show Screening"
      assert html =~ screening.recipient_email
    end

    test "updates screening within modal", %{conn: conn, screening: screening} do
      {:ok, show_live, _html} = live(conn, Routes.screening_show_path(conn, :show, screening))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Screening"

      assert_patch(show_live, Routes.screening_show_path(conn, :edit, screening))

      assert show_live
             |> form("#screening-form", screening: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#screening-form", screening: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.screening_show_path(conn, :show, screening))

      assert html =~ "Screening updated successfully"
      assert html =~ "some updated recipient_email"
    end
  end
end
