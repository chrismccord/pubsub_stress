defmodule PubsubStress.SimulatedSubscribers do
  use GenServer
  require Logger

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init([subscriber_count, topic]) do
    subscriptions = for _ <- 1..subscriber_count  do
      spawn_link fn ->
        PubsubStress.Endpoint.subscribe(self, topic, link: true)
        listen = fn recur ->
          receive do
            %Phoenix.Socket.Broadcast{} ->
              recur.(recur)
          end
        end
        listen.(listen)
      end
    end
    IO.puts "#{inspect self}#{subscriber_count} subscribers listening on \"#{topic}\""
    {:ok, subscriptions}
  end
end
