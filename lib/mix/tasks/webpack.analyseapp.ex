defmodule Mix.Tasks.Webpack.Analyseapp do
  @shortdoc "Generate webpack stats analysing application, resulting priv/static is meant to be versionned"
  def run(_args) do
    File.rm_rf!("priv/static")
    {_,0} = System.cmd("git",["clone","-b","ajax-sse-loading","https://github.com/awetzel/analyse"], into: IO.stream(:stdio, :line))
    {_,0} = System.cmd("npm",["install"], into: IO.stream(:stdio, :line), cd: "analyse")
    {_,0} = System.cmd("grunt",[], into: IO.stream(:stdio, :line), cd: "analyse")
    File.cp_r!("analyse/dist", "priv/static")
    File.rm_rf!("analyse")
  end
end
