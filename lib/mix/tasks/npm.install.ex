defmodule Mix.Tasks.Npm.Install do
  @shortdoc "`npm install` in web_dir + npm install server side dependencies"
  def run(_args) do
    System.cmd("npm",["install"], into: IO.stream(:stdio, :line), cd: WebPack.Util.web_app)
    System.cmd("npm",["install","#{:code.priv_dir(:lyn)}/commonjs_reaxt"], into: IO.stream(:stdio, :line), cd: WebPack.Util.web_app)
  end
end
