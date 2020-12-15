defmodule ScreenerLiveWeb.PageLive do
  use ScreenerLiveWeb, :live_view

  alias ScreenerLive.Screenings
  alias ScreenerLive.Screenings.Screening
  alias ScreenerLive.Screenings.Video
  alias ScreenerLive.Accounts

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    {:ok,
     assign(socket, user: user, videos: list_videos(user), screenings: list_screenings(user))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit_video, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Video")
    |> assign(:video, Screenings.get_video!(id))
  end

  defp apply_action(socket, :new_video, _params) do
    socket
    |> assign(:page_title, "New Video")
    |> assign(:video, %Video{})
  end

  defp apply_action(socket, :edit_screening, %{"id" => id}) do
    screening = Screenings.get_screening_with_video!(id)

    socket
    |> assign(:page_title, "Edit Screening")
    |> assign(:screening, screening)
    |> assign(:video, screening.video)
  end

  defp apply_action(socket, :new_screening, _params) do
    socket
    |> assign(:page_title, "New Screening")
    |> assign(:screening, %Screening{})
    |> assign(:video, nil)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Screener")
    |> assign(:video, nil)
    |> assign(:screening, nil)
  end

  @impl true
  def handle_event("delete_screening", %{"id" => id}, socket) do
    screening = Screenings.get_screening!(id)
    {:ok, _} = Screenings.delete_screening(screening)

    {:noreply,
     socket
     |> put_flash(:info, "Screening deleted")
     |> assign(:screenings, list_screenings(socket.assigns.user))}
  end

  @impl true
  def handle_event("delete_video", %{"id" => id}, socket) do
    video = Screenings.get_video!(id)
    {:ok, _} = Screenings.delete_video(video)

    {:noreply,
     socket
     |> put_flash(:info, "Video deleted")
     |> assign(:videos, list_videos(socket.assigns.user.id))}
  end

  defp list_videos(user) do
    Screenings.list_videos_by_user(user)
  end

  defp list_screenings(user) do
    Screenings.list_screenings_by_user(user)
  end
end
