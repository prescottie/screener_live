defmodule ScreenerLiveWeb.VideoLive.Index do
  use ScreenerLiveWeb, :live_view

  alias ScreenerLive.Screenings
  alias ScreenerLive.Screenings.Video
  alias ScreenerLive.Accounts

  @impl true
  def mount(_params, session, socket) do
    user_id = Accounts.get_user_by_session_token(session["user_token"]).id

    {:ok,
     assign(socket,
       videos: list_videos(user_id),
       user_id: user_id
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Video")
    |> assign(:video, Screenings.get_video!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Video")
    |> assign(:video, %Video{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Videos")
    |> assign(:video, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    video = Screenings.get_video!(id)
    {:ok, _} = Screenings.delete_video(video)

    {:noreply, assign(socket, :videos, list_videos(socket.assigns.user_id))}
  end

  defp list_videos(user_id) do
    Screenings.list_videos_by_user_id(user_id)
  end
end
