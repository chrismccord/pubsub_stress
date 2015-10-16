defmodule PubsubStress.WebSocketSimulator do
  use GenServer
  require Logger
  alias PubsubStress.WebSocketClient

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init([client_count, port]) do
    sockets = for range <- Enum.chunk(1..client_count, 10) do
      for i <- range do
        Task.async(fn ->
          {:ok, socket} = WebSocketClient.start_link(self, "ws://127.0.0.1:#{port}/socket/websocket")
          WebSocketClient.join(socket, "rooms:lobby", %{})
          IO.puts i
          socket
        end)
      end |> Enum.map(&Task.await(&1))
    end

    sockets = List.flatten(sockets)
    IO.puts "#{Enum.count(sockets)} WebSocket clients joined \"rooms:lobby\""
    {:ok, sockets}
  end

end
