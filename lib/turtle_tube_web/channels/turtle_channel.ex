defmodule TurtleTubeWeb.TurtleChannel do
  @moduledoc "Channel for the camera to connect to."
  use TurtleTubeWeb, :channel

  def join("turtle:" <> name, _message, socket) do
    send self(), :after_connect
    {:ok, assign(socket, :turtle_name, name)}
  end
  
  def handle_in(event, payload, socket) do
    if socket.assigns[:timer] do
      Process.cancel_timer(socket.assigns[:timer])
    end
    # IO.inspect(event, label: "turtle channel event")
    # IO.inspect payload, label: "turtle channel payload"
    Phoenix.PubSub.broadcast!(TurtleTube.PubSub, "turtle:#{socket.assigns.turtle_name}", {event, payload})
    timer = Process.send_after(self(), :after_connect, 5_000)
    {:reply, {:ok, %{}}, assign(socket, :timer, timer)}
  end

  def handle_info(:after_connect, socket) do
    push(socket, "after_connect", %{})
    {:noreply, socket}
  end

  def handle_info({_, _}, socket) do
    {:noreply, socket}
  end
end