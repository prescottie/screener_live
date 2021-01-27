defmodule ScreenerLiveWeb.ScreeningLive.Show do
  use ScreenerLiveWeb, :live_view

  alias ScreenerLive.Screenings
  alias ScreenerLive.Screenings.Screening

  @impl true
  def mount(params, _session, socket) do
    with {:ok, decoded_uuid} <- Base.url_decode64(params["uuid"], padding: false) do
      {:ok, assign(socket, uuid: decoded_uuid, screener: nil, error: nil)}
    else
      _ -> {:ok, assign(socket, uuid: nil, screener: true, error: "not_found")}
    end
  end

  @impl true
  def handle_event("playback_started", _params, socket) do
    case Screenings.consume_screening(socket.assigns.screener) do
      {:ok, screening} ->
        {:noreply, assign(socket, screener: screening)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, screener: nil)}
    end
  end

  @impl true
  def handle_event("exchange_email", params, socket) do
    with true <- String.valid?(socket.assigns.uuid),
         screener <-
           Screenings.load_consumer_screener(socket.assigns.uuid, params["screener"]["email"]),
         error <- Screening.error_type(screener) do
      {:noreply, assign(socket, screener: screener, error: error)}
    else
      _ -> {:noreply, assign(socket, error: "not_found")}
    end
  end

  @impl true
  def handle_params(%{"uuid" => uuid}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "View Screener")
     |> assign(:screening, nil)}
  end
end
