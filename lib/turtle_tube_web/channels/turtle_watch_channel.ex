defmodule TurtleTubeWeb.TurtleWatchChannel do
  use TurtleTubeWeb, :channel
  alias TurtleTube.Presence

  def join("turtle_watch:" <> turtle_name, %{"uuid" => uuid}, socket) do
    send self(), :after_join
    {:ok, assign(socket, :uuid, uuid) |> assign(:turtle_name, turtle_name)}
  end

  def handle_info(:after_join, socket) do
    push(socket, "presence_state", Presence.list(socket))
    {:ok, _} = Presence.track(socket, socket.assigns.uuid, %{
      online_at: inspect(System.system_time(:second))
    })
    Phoenix.PubSub.subscribe(TurtleTube.PubSub, "turtle:" <> socket.assigns.turtle_name)
    {:noreply, socket}
  end

  def handle_info({event, payload}, socket) do
    broadcast(socket, event, payload)
    {:noreply, socket}
  end
end