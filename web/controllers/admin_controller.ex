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
        page = case conn.assigns[:page] do
          nil ->
            Repo.all(model)
          page ->
            page
        end
        if function_exported? model, :index_view, 2 do
          apply(model, :index_view, [conn, page])
        else
          render(conn, "index.html", entries: page)
        end
    end

    conn
    |> render("dashboard.html")
  end
end
