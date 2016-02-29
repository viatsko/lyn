defmodule Lyn.Mixfile do
  use Mix.Project

  def project do
    [app: :lyn,
     version: "0.0.8",
     elixir: "~> 1.2.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     description: description,
     package: package,
     deps: deps,
     docs: docs]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Lyn, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :comeonin]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:comeonin, "~> 2.1.1"},
     {:inflex, "~> 1.5.0"},
     {:json, "~> 0.3.3"},
     {:earmark, "~> 0.2.1", only: :dev},
     {:ex_doc, "~> 0.11.4", only: :dev},
     {:ex_machina, "~> 0.6.1", only: :test},
     {:phoenix, "~> 1.1.4"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_ecto, "~> 2.0.1"},
     {:phoenix_html, "~> 2.5.0"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:scrivener, "~> 1.1.2"},
     {:gettext, "~> 0.10.0"},
     {:cowboy, "~> 1.0.4"}]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end

  defp description do
    """
    Elixir CMS
    """
  end

  defp docs do
    [
      extras: [
        "README.md",
        "CONTRIBUTING.md"
      ]
    ]
  end

  defp package do
    [# These are the default files included in the package
     files: [
       "config",
       "docs",
       "lib",
       "priv",
       "test",
       "web",
       ".babelrc",
       ".eslintrc",
       ".eslintignore",
       ".iex.exs",
       "mix.exs",
       "package.json",
       "webpack.config.js",
       "README.md",
       "LICENSE.md"
     ],
     maintainers: ["Valerii Iatsko"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/viatsko/lyn",
              "Docs" => "https://github.com/viatsko/lyn/tree/master/docs"}]
  end
end
