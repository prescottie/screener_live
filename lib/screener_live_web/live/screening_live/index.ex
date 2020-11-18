defmodule ScreenerLiveWeb.ScreeningLive.Index do
  use ScreenerLiveWeb, :live_view

  alias ScreenerLive.Screenings
  alias ScreenerLive.Screenings.Screening

  @impl true
  def mount(%{"video_uuid" => video_uuid}, _session, socket) do
    {:ok, assign(socket, screenings: list_screenings(), video_uuid: video_uuid)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"video_uuid" => video_uuid, "id" => id}) do
    socket
    |> assign(:page_title, "Edit Screening")
    |> assign(:screening, Screenings.get_screening!(id))
  end

  defp apply_action(socket, :new, %{"video_uuid" => video_uuid}) do
    socket
    |> assign(:page_title, "New Screening")
    |> assign(:screening, %Screening{})
  end

  defp apply_action(socket, :index, %{"video_uuid" => video_uuid}) do
    socket
    |> assign(:page_title, "Listing Screenings")
    |> assign(:screening, nil)
  end

  @impl true
  def handle_event("delete", %{"video_uuid" => video_uuid, "id" => id}, socket) do
    screening = Screenings.get_screening!(id)
    {:ok, _} = Screenings.delete_screening(screening)

    {:noreply, assign(socket, :screenings, list_screenings())}
  end

  defp list_screenings do
    Screenings.list_screenings()
  end
end
