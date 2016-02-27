defmodule Lyn.LinkHelper do
  use Application

  def sidebar(conn) do
    path = Enum.at(conn.path_info, 1)

    if !path do
      nil
    else
      path = path <> ".html"

      eex_path = Path.join([Application.app_dir(:lyn), "../../../../web/templates/admin/sidebar", path <> ".eex"])

      if File.exists?(eex_path) do
        path
      else
        nil
      end
    end
  end

  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])
    if path == current_path do
      "active"
    else
      nil
    end
  end
end
