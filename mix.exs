defmodule PubsubStress.Mixfile do
  use Mix.Project

  def project do
    [app: :pubsub_stress,
     version: "0.0.1",
     elixir: "~> 1.1",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {PubsubStress, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.0.3"},
     {:websocket_client, github: "jeremyong/websocket_client"},
     {:phoenix_html, "~> 1.1"},
     {:cowboy, "~> 1.0"}]
  end
end
