defmodule ScreenerLiveWeb.Screenings.ScreeningFormComponent do
  use ScreenerLiveWeb, :live_component

  alias ScreenerLive.Screenings
  alias ScreenerLive.Screenings.ScreeningNotifier

  @impl true
  def update(%{screening: screening} = assigns, socket) do
    changeset = Screenings.change_screening(screening)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"screening" => screening_params}, socket) do
    changeset =
      socket.assigns.screening
      |> Screenings.change_screening(screening_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"screening" => screening_params}, socket) do
    save_screening(socket, socket.assigns.action, screening_params)
  end

  defp save_screening(socket, :edit_screening, screening_params) do
    case Screenings.update_screening(socket.assigns.screening, screening_params) do
      {:ok, _screening} ->
        {:noreply,
         socket
         |> put_flash(:info, "Screening updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_screening(socket, :new_screening, screening_params) do
    case Screenings.create_screening(screening_params) do
      {:ok, screening} ->
        video = Enum.find(socket.assigns.videos, fn x -> x.id == screening.video_id end)
        ScreeningNotifier.deliver_new_screening(screening, video)

        {:noreply,
         socket
         |> put_flash(:info, "Screening created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
