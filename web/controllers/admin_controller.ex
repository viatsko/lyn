defmodule Lyn.AdminController do
  use Lyn.Web, :controller

  import Lyn.ParamsToAtoms

  alias Lyn.Domain
  alias Lyn.Language
  alias Lyn.ObjectType
  alias Lyn.Site

  def models, do: %{
    "domains" => Domain,
    "languages" => Language,
    "object_types" => ObjectType,
    "sites" => Site
  }

  plug :put_layout, "admin.html"

  def index(conn, params) do
    model = models[params["resource"]]

    contents = case model do
      nil ->
        throw :invalid_route
      model ->
        entries = case conn.assigns[:entries] do
          nil ->
            Repo.all(model)
          entries ->
            entries
        end

        columns = Enum.drop(Map.keys(model.__struct__), 2)

        render(conn, "index.html", entries: entries, columns: columns)
    end

    conn
    |> render("dashboard.html")
  end
end
