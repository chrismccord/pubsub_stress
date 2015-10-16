defmodule PubsubStress do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    remote_port = System.get_env("REMOTE_PORT")
    subscriber_count = case System.get_env("SUBSCRIBERS") do
      nil -> 700
      count -> Integer.parse(count) |> elem(0)
    end

    ws_clients = case System.get_env("WS_CLIENTS") do
      nil -> 0
      count -> Integer.parse(count) |> elem(0)
    end

    children = [
      supervisor(PubsubStress.Endpoint, []),
      worker(PubsubStress.SimulatedSubscribers,
             [[subscriber_count, "rooms:lobby"]]),
      worker(PubsubStress.QueueLenChecker, [PubsubStress.PubSub.Local]),
    ]
    if ws_clients > 0 do
      children = children ++ [worker(PubsubStress.WebSocketSimulator, [[ws_clients, remote_port]])]
    end

    opts = [strategy: :one_for_one, name: PubsubStress.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PubsubStress.Endpoint.config_change(changed, removed)
    :ok
  end
end
