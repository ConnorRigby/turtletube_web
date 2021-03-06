defmodule TurtleTube.MixProject do
  use Mix.Project

  def project do
    [
      app: :turtle_tube,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {TurtleTube.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.0-rc or ~> 1.4", override: true},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_live_reload, "~> 1.2.0-rc or ~> 1.2", only: :dev},
      {:phoenix_html, "~> 2.12"},
      {:plug, "~> 1.7"},
      {:plug_cowboy, "~> 2.0"},
      {:cowboy, "~> 2.0", override: true},
      {:jason, "~> 1.0"},
      {:gettext, "~> 0.11"},
      {:distillery, "~> 2.0"},
      {:phoenix_channel_client, "~> 0.3", only: :test},
      {:websocket_client, "~> 1.3", only: :test},
    ]
  end
end
