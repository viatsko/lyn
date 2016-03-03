defmodule Lyn.PageController do
  use Lyn.Web, :controller

  def index(conn, _params, current_user, _claims) do
    render conn, "index.html"
  end
end
