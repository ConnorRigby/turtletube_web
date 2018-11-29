defmodule TurtleTubeWeb.TurtleWatchChannel do
  use TurtleTubeWeb, :channel

  def join("turtle_watch:*", _message, socket) do
    Phoenix.PubSub.subscribe(TurtleTube.PubSub, "turtle:thadeous")
    {:ok, socket}
  end

  def handle_info({event, payload}, socket) do
    broadcast(socket, event, payload)
    {:noreply, socket}
  end
end