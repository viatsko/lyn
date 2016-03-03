defmodule Lyn.WebPackController do
  use Lyn.Web, :controller

  def stats(conn, _params, current_user, _claims) do
    conn
    |> put_resp_content_type("application/json")
    |> send_file(200,"#{WebPack.Util.web_priv}/webpack.stats.json")
  end

  def index(conn, _params, current_user, _claims) do
    %{conn|path_info: ["webpack","static","index.html"]}
  end

  def events(conn, _params, current_user, _claims) do
    conn = conn
        |> put_resp_header("content-type", "text/event-stream")
        |> send_chunked(200)

    hot? = Application.get_env(:lyn,:hot)
    if hot? == :client, do: Plug.Conn.chunk(conn, "event: hot\ndata: nothing\n\n")
    if hot?, do:
      GenEvent.add_mon_handler(WebPack.Events,{WebPack.Plug.Static.EventHandler,make_ref},conn)
    receive do {:gen_event_EXIT,_,_} -> conn end
  end

  def client(conn, _params, current_user, _claims) do
    conn
    |> put_resp_content_type("application/javascript")
    |> send_file(200,"web/node_modules/reaxt/webpack_client.js")
  end

  def file(conn, params, current_user, _claims) do
    %{conn|path_info: ["webpack","static",params["name"]]}
  end
end
