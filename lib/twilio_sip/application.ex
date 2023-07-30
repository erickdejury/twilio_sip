defmodule TwilioSip.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TwilioSipWeb.Telemetry,
      # Start the Ecto repository
      TwilioSip.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TwilioSip.PubSub},
      # Start Finch
      {Finch, name: TwilioSip.Finch},
      # Start the Endpoint (http/https)
      TwilioSipWeb.Endpoint
      # Start a worker by calling: TwilioSip.Worker.start_link(arg)
      # {TwilioSip.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TwilioSip.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TwilioSipWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
