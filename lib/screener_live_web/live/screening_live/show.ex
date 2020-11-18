defmodule ScreenerLiveWeb.ScreeningLive.Show do
  use ScreenerLiveWeb, :live_view

  alias ScreenerLive.Screenings

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:screening, Screenings.get_screening!(id))}
  end

  defp page_title(:show), do: "Show Screening"
  defp page_title(:edit), do: "Edit Screening"
end
