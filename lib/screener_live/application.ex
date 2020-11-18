defmodule ScreenerLive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ScreenerLive.Repo,
      # Start the Telemetry supervisor
      ScreenerLiveWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ScreenerLive.PubSub},
      # Start the Endpoint (http/https)
      ScreenerLiveWeb.Endpoint
      # Start a worker by calling: ScreenerLive.Worker.start_link(arg)
      # {ScreenerLive.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ScreenerLive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ScreenerLiveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
