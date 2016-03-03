defmodule Mix.Tasks.Webpack.Compile do
  @shortdoc "Compiles Webpack"
  @webpack "./node_modules/webpack/bin/webpack.js"
  def run(_) do
    {_res,0} = compile_server
    {json,0} = compile_client
    File.write!("priv/webpack.stats.json",json)
  end
  def compile_server() do
    server_config = "./node_modules/reaxt/server.webpack.config.js"
    System.cmd("node",[@webpack,"--config",server_config,"--colors"], into: IO.stream(:stdio, :line), cd: WebPack.Util.web_app)
  end
  def compile_client() do
    client_config = "./node_modules/reaxt/client.webpack.config.js"
    System.cmd("node",[@webpack,"--config",client_config,"--json"], into: "", cd: WebPack.Util.web_app)
  end
end
