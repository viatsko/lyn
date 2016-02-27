defmodule Lyn.Admin.MaintenanceController do
  use Lyn.Web, :controller

  plug :put_layout, "admin.html"

  def index(conn, _params) do
    render conn, "index.html"
  end
end
