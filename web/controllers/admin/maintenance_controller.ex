defmodule Lyn.Admin.MaintenanceController do
  use Lyn.Web, :admin_controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def checkdb(conn, _params) do
    render conn, "checkdb.html"
  end

  def reset_cache(conn, _params) do
    render conn, "reset_cache.html"
  end

  def dbdump(conn, _params) do
    render conn, "dbdump.html"
  end

  def dbload(conn, _params) do
    render conn, "dbload.html"
  end

  def system_limits(conn, _params) do
    render conn, "system_limits.html", env: System.get_env(), build_info: System.build_info()
  end
end
