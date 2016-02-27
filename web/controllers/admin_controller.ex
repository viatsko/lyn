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

  def dashboard(conn, params) do
    render(conn, "dashboard.html")
  end

  def index(conn, params) do
    model = models[params["resource"]]

    contents = case model do
      nil ->
        render(conn, "dashboard.html")
      model ->
        entries = case conn.assigns[:entries] do
          nil ->
            Repo.all(model)
          entries ->
            entries
        end

        columns = Enum.drop(Map.keys(model.__struct__), 2)

        render(conn, "index.html", entries: entries, columns: model.admin_fields)
    end
  end

  def new(conn, params) do
    model = models[params["resource"]]

    changeset = model.changeset(struct(model))

    render(conn, "new.html", changeset: changeset, columns: model.admin_fields)
  end
end
