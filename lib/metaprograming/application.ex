defmodule Metaprograming.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MetaprogramingWeb.Telemetry,
      Metaprograming.Repo,
      {DNSCluster, query: Application.get_env(:metaprograming, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Metaprograming.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Metaprograming.Finch},
      # Start a worker by calling: Metaprograming.Worker.start_link(arg)
      # {Metaprograming.Worker, arg},
      # Start to serve requests, typically the last entry
      MetaprogramingWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Metaprograming.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MetaprogramingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
