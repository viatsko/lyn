defmodule Lyn.Mixfile do
  use Mix.Project

  def project do
    [app: :lyn,
     version: "0.0.14",
     elixir: "~> 1.2.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext, :reaxt_webpack] ++ Mix.compilers,
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
    dev_apps = Mix.env == :dev && [:reprise] || []

    [mod: {Lyn, []},
     applications: [:phoenix,
                    :phoenix_html,
                    :cowboy,
                    :logger,
                    :gettext,
                    :phoenix_ecto,
                    :postgrex,
                    :comeonin,
                    :ueberauth,
                    :ueberauth_facebook,
                    :ueberauth_github,
                    :ueberauth_google,
                    :ueberauth_identity,
                    :ueberauth_slack,
                    :ueberauth_twitter,
                    :exos,
                    :poolboy] ++ dev_apps]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:comeonin, "~> 2.1.1"},
     {:cowboy, "~> 1.0.4"},
     {:dogma, "~> 0.1.1", only: :dev},
     {:earmark, "~> 0.2.1", only: :dev},
     {:ex_doc, "~> 0.11.4", only: :dev},
     {:ex_machina, "~> 0.6.1", only: :test},
     {:exos, "1.0.0"},
     {:gettext, "~> 0.10.0"},
     {:guardian_db, "~> 0.4"},
     {:guardian, "~> 0.9.0"},
     {:inflex, "~> 1.5.0"},
     {:json, "~> 0.3.3"},
     {:oauth, github: "tim/erlang-oauth"},
     {:phoenix, "~> 1.1.4"},
     {:phoenix_ecto, "~> 2.0.1"},
     {:phoenix_html, "~> 2.5.0"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:poison, "~> 1.5.2"},
     {:poolboy, "~> 1.5.1"},
     {:postgrex, ">= 0.0.0"},
     {:reprise, "~> 0.5", only: :dev},
     {:scrivener, "~> 1.1.2"},
     {:ueberauth, "~> 0.2"},
     {:ueberauth_facebook, "~> 0.3.2"},
     {:ueberauth_github, "~> 0.2"},
     {:ueberauth_google, "~> 0.2"},
     {:ueberauth_identity, "~> 0.2.2"},
     {:ueberauth_slack, "~> 0.2"},
     {:ueberauth_twitter, "~> 0.2.2"}]
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
    This is a CMS written in Elixir. Aims to be the great open-source ecommerce and/or startup
    solution for those who are searching for a performance and stability on top of modern technologies
    like React and Elixir.
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
