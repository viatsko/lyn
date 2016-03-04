defmodule Mix.Tasks.Reaxt.Validate do
  @shortdoc "Validates that reaxt is setup correct"
  use Mix.Task

  def run(args) do
    if Enum.all?(args, &(&1 != "--reaxt-skip-validation")) do
      validate(args)
    end
  end

  def validate(args) do
    if WebPack.Util.web_priv == :no_app_specified, do:
      Mix.raise """
                Reaxt :otp_app is not configured.
                Add following to config.exs
                  config :lyn, :otp_app, :your_app
                """

    if (Enum.all?(args, &(&1 != "--reaxt-skip-compiler-check"))
        and Enum.all? (Mix.Project.get!).project[:compilers], &(&1 != :reaxt_webpack)), do:
      Mix.raise """
                Reaxt has a built in compiler that compiles the web app.
                Remember to add it to the list of compilers in mix.exs:
                  def project do
                    [...
                      app: :your_app,
                      compilers: [:reaxt_webpack] ++ Mix.compilers,
                      ...]
                  end
                """
  end
end
