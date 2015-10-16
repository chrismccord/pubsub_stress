defmodule PubsubStress.QueueLenChecker do
  def start_link(local) do
    Task.start_link __MODULE__, :check, [local]
  end

  def check(local) do
    :timer.sleep(10_000)
    {:message_queue_len, len} = Process.info(Process.whereis(local), :message_queue_len)
    IO.puts Integer.to_string(len)
    check(local)
  end
end
