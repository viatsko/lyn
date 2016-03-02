defmodule Lyn.SidebarHelper do
  use Application

  def sidebar(conn) do
    path = Enum.at(conn.path_info, 1)

    if !path do
      "objects.html"
    else
      path = path <> ".html"

      eex_path = Path.join([Application.app_dir(:lyn), "../../../../web/templates/admin/sidebar", path <> ".eex"])

      if File.exists?(eex_path) do
        path
      else
        "objects.html"
      end
    end
  end
end
