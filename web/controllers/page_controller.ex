defmodule Lyn.PageController do
  use Lyn.Web, :controller

  # if Mix.env == :dev do
  #   use Plug.Debugger
  #   plug WebPack.Plug.Static, at: "/public", from: :reaxt_example
  # else
  #   plug Plug.Static, at: "/public", from: :reaxt_example
  # end
  # plug :match
  # plug :dispatch

  @layout """
  <html>
  <head>
    <%= WebPack.header %>
    <style><%= render.css %></style>
  </head>
  <body>
    <h1> Reaxt application example </h1>
    <div style="background-color: #BBB; padding: 20px"><h4 style="color: #FFF">Rendering area</h4>
      <div id="content"><%= render.html %></div>
    </div>
    <h2>Targeted module is directly a react component</h2>
    <ul>
      <li><a href="/">Root app with subcomponent and state</a></li>
      <li><a href="/subcomponent">Render a subcomponent alone with css</a></li>
    </ul>
    <h2>Targeted module implements reaxt_server_render and reaxt_client_render (here react-router)</h2>
    <ul>
      <li><a href="/myrouter/routed-app">First Link rendered and routed by react-router</a></li>
      <li><a href="/myrouter/routed-css-app">Second Link rendered and routed by react-router</a></li>
      <li><a href="/myrouter/toto">routed by React router, no route match, default handler</a></li>
    </ul>
    <h2>Error management</h2>
    <ul>
      <li><a href="/with_stacktrace">JS error with stacktrace</a></li>
      <li><a href="/without_stacktrace">JS error without stacktrace</a></li>
    </ul>
    <script src="http://fb.me/react-0.12.2.js"></script>
    <script src="/public/<%= WebPack.file_of(:main) %>"></script>
    <script><%= render.js_render %>("content")</script>
  </body>
  </html>
  """

  defp send_rendered_resp(conn,component) do
    render = Reaxt.render!(component,%{items: ["Home","Contact","Pages"]})
    send_resp(conn, 200,EEx.eval_string(@layout,render: render))
  end

  def index(conn,_params, _current_user, _claims), do:
    send_rendered_resp(conn,:app)
  def with_stacktrace(conn,_params, _current_user, _claims), do:
    send_rendered_resp(conn,{:multi_components,:with_stacktrace})
  def without_stacktrace(conn,_params, _current_user, _claims), do:
    send_rendered_resp(conn,{:multi_components,:no_stacktrace})
  def subcomponent(conn,_params, _current_user, _claims), do:
    send_rendered_resp(conn,{:multi_components,:with_css})

  def myrouter(conn,_params, _current_user, _claims) do
    ## this part use react_router as an example of dynamic handler selection
    render = Reaxt.render!(:my_router, conn.request_path)
    send_resp(conn, 200,EEx.eval_string(@layout,render: render))
  end

  def file(conn,params, _current_user, _claims) do
    # %{conn|path_info: ["webpack","static",params["filename"]]}
    text conn, File.read!(Path.join([:code.priv_dir(:reaxt_phoenix_example), "static", params["filename"]]))
    #text(conn, "hello #{params["filename"]}")  #%{conn|path_info: ["static",params["filename"]]}
    #send_file(conn, Path.join(:code.priv_dir("static"), params["filename"]))
  end
end
