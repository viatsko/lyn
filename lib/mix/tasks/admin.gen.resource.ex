defmodule Mix.Tasks.Admin.Gen.Resource do
  @moduledoc """
  Generate an Lyn Resource file

  Creates a resource file used to define the administration pages
  for the auto administration feature

      mix admin.gen.resource Survey

  Creates a web/admin/survey.ex file.

  """

  @shortdoc "Generate a Resource file"

  use Mix.Task
  import Mix.Lyn.Utils

  defmodule Config do
    defstruct module: nil, package_path: nil
  end

  def run(args) do
    parse_args(args)
    |> copy_file
  end


  defp copy_file(%Config{module: module, package_path: package_path} = config) do
    filename = String.downcase(module) <> ".ex"
    dest_path = Path.join ~w(web admin)
    dest_file_path = Path.join dest_path, filename
    source_file = Path.join([package_path | ~w(priv templates admin.gen.resource resource.exs)] )
    source = source_file  |> EEx.eval_file(base: get_module, resource: module)
    status_msg "creating", dest_file_path
    File.write! dest_file_path, source
  end

  defp parse_args([module]) do
    %Config{module: module, package_path: get_package_path}
  end

end
