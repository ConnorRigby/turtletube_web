defmodule TurtleTube.Presence do
  use Phoenix.Presence, otp_app: :turtle_tube,
                        pubsub_server: TurtleTube.PubSub
end