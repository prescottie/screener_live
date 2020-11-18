defmodule ScreenerLiveWeb.VideoLive.Show do
  use ScreenerLiveWeb, :live_view

  alias ScreenerLive.Screenings

  @impl true
  def mount(_params, session, socket) do
    {:ok, assign(socket, user_token: session["user_token"])}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:video, Screenings.get_video!(id))}
  end

  defp page_title(:show), do: "Show Video"
  defp page_title(:edit), do: "Edit Video"
end
