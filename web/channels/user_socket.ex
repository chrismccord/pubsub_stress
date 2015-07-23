defmodule PubsubStress.UserSocket do
  use Phoenix.Socket

  channel "rooms:*", PubsubStress.RoomChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_), do: nil
end
