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
    <title>Lyn App</title>
    <style><%= render.css %></style>
  </head>
  <body>
    <div id="content"><%= render.html %></div>
    <script src="/public/<%= WebPack.file_of(:main) %>"></script>
    <script><%= render.js_render %>("content")</script>
  </body>
  </html>
  """

  defp send_rendered_resp(conn, component) do
    #render = Reaxt.render!(:my_router, conn.request_path)
    render = Reaxt.render!(component, %{
      location: conn.request_path,
      items: ["Home","Contact","Pages"]
    })
    #render = Reaxt.render!(:App, conn.request_path)

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, EEx.eval_string(@layout, render: render))
  end

  def index(conn,_params, _current_user, _claims), do:
    send_rendered_resp(conn, :index)

  def file(conn,params, _current_user, _claims) do
    # %{conn|path_info: ["webpack","static",params["filename"]]}
    conn
    |> put_resp_content_type("text/javascript")
    |> text(File.read!(Path.join([:code.priv_dir(:lyn), "static", params["filename"]])))
    #text(conn, "hello #{params["filename"]}")  #%{conn|path_info: ["static",params["filename"]]}
    #send_file(conn, Path.join(:code.priv_dir("static"), params["filename"]))
  end
end
