defmodule PubsubStress do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    subscriber_count = case System.get_env("SUBSCRIBERS") do
      nil -> 700
      count -> Integer.parse(count) |> elem(0)
    end

    children = [
      supervisor(PubsubStress.Endpoint, []),
      worker(PubsubStress.SimulatedSubscribers,
             [[subscriber_count, "rooms:123"]]),
    ]

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