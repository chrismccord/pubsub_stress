defmodule PubsubStress.RoomChannel do
  use Phoenix.Channel

  def join("rooms:" <> _, _params, socket) do
    {:ok, socket}
  end

end
