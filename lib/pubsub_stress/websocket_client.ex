defmodule PubsubStress.WebSocketClient do
  alias Poison, as: JSON

  @doc """
  Starts the WebSocket server for given ws URL. Received Socket.Message's
  are forwarded to the sender pid
  """
  def start_link(sender, url, headers \\ []) do
    :crypto.start
    :ssl.start
    :websocket_client.start_link(String.to_char_list(url), __MODULE__, [sender],
                                 extra_headers: headers)
  end

  def init([sender], _conn_state) do
    # send(self, :up)
    {:ok, %{sender: sender, ref: 0}}
  end

  @doc """
  Closes the socket
  """
  def close(socket) do
    send(socket, :close)
  end

  @doc """
  Receives JSON encoded Socket.Message from remote WS endpoint and
  forwards message to client sender process
  """
  def websocket_handle({:text, encoded_msg}, _conn_state, state) do
    msg = Phoenix.Transports.WebSocketSerializer.decode!(encoded_msg, :text)
    if msg.ref == "1" do
      send(self, :after_join)
    end
    # send state.sender, msg
    {:ok, state}
  end

  def websocket_info(:after_join, _conn_state, state) do
    {:reply, {:text, json!(%{"topic" => "rooms:lobby", "event" => "new:msg", "payload" => %{"body" => "foo"}, "ref" => state.ref})}, put_in(state, [:ref], state.ref + 1)}
  end

  @doc """
  Sends JSON encoded Socket.Message to remote WS endpoint
  """
  def websocket_info({:send, msg}, _conn_state, state) do
    msg = Map.put(msg, :ref, to_string(state.ref + 1))
    {:reply, {:text, json!(msg)}, put_in(state, [:ref], state.ref + 1)}
  end

  def websocket_info(:close, _conn_state, _state) do
    {:close, <<>>, "done"}
  end

  def websocket_terminate(_reason, _conn_state, _state) do
    :ok
  end

  @doc """
  Sends an event to the WebSocket server per the Message protocol
  """
  def send_event(server_pid, topic, event, msg) do
    send server_pid, {:send, %{topic: topic, event: event, payload: msg}}
  end

  @doc """
  Sends join event to the WebSocket server per the Message protocol
  """
  def join(server_pid, topic, msg) do
    send_event(server_pid, topic, "phx_join", msg)
  end

  @doc """
  Sends leave event to the WebSocket server per the Message protocol
  """
  def leave(server_pid, topic, msg) do
    send_event(server_pid, topic, "phx_leave", msg)
  end

  defp json!(map), do: JSON.encode!(map)
end
