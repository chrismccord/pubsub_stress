defmodule PubsubStress.WebSocketSimulator do
  use GenServer
  require Logger
  alias PubsubStress.WebSocketClient

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(client_count) do
    sockets = for _ <- 1..client_count do
      {:ok, socket} = WebSocketClient.start_link(self, "ws://127.0.0.1:#{System.get_env("PORT")}/ws/websocket")
      WebSocketClient.join(socket, "rooms:lobby", %{})
      socket
    end
    IO.puts "#{Enum.count(sockets)} WebSocket clients joined \"rooms:lobby\""
    {:ok, sockets}
  end

end
