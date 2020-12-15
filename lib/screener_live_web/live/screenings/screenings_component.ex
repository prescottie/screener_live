defmodule ScreenerLiveWeb.Screenings.ScreeningsComponent do
  use ScreenerLiveWeb, :live_component

  # alias ScreenerLive.Screenings
  # alias ScreenerLive.Screenings.Screening
  # alias ScreenerLive.Accounts

  # @impl true
  # def mount(%{"video_uuid" => video_uuid}, session, socket) do
  #   user_id = Accounts.get_user_by_session_token(session["user_token"]).id

  #   {:ok,
  #    assign(socket,
  #      screenings: list_screenings(video_uuid, user_id),
  #      video_uuid: video_uuid,
  #      user_id: user_id
  #    )}
  # end

  # @impl true
  # def handle_params(params, _url, socket) do
  #   {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  # end

  # defp apply_action(socket, :edit, %{"video_uuid" => video_uuid, "id" => id}) do
  #   socket
  #   |> assign(:page_title, "Edit Screening")
  #   |> assign(:screening, Screenings.get_screening!(id))
  # end

  # defp apply_action(socket, :new, %{"video_uuid" => video_uuid}) do
  #   socket
  #   |> assign(:page_title, "New Screening")
  #   |> assign(:screening, %Screening{})
  # end

  # defp apply_action(socket, :index, %{"video_uuid" => video_uuid}) do
  #   socket
  #   |> assign(:page_title, "Listing Screenings")
  #   |> assign(:screening, nil)
  # end

  # @impl true
  # def handle_event("delete", %{"video_uuid" => video_uuid, "id" => id}, socket) do
  #   screening = Screenings.get_screening!(id)
  #   {:ok, _} = Screenings.delete_screening(screening)

  #   {:noreply, assign(socket, :screenings, list_screenings(video_uuid, socket.assigns.user_id))}
  # end

  # defp list_screenings(video_uuid, user_id) do
  #   case Screenings.get_video_by_uuid_and_user_id(video_uuid, user_id) do
  #     nil -> []
  #     video -> Screenings.list_screenings_by_video_id(video.id)
  #   end
  # end
end
