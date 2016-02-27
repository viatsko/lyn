defmodule Lyn.AdminController do
  use Lyn.Web, :controller

  import Lyn.ParamsToAtoms
  import Inflex

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

  def index(conn, %{"resource" => resource}) do
    model = models[resource]

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

        render(conn, "index.html", entries: entries, columns: model.admin_fields, resource: resource)
    end
  end

  def new(conn, %{"resource" => resource}) do
    model = models[resource]

    changeset = model.changeset(struct(model))

    render(conn, "new.html", changeset: changeset, columns: model.admin_fields, resource: resource)
  end

  def create(conn, params) do
    resource = params["resource"]

    model = models[resource]

    changeset = model.changeset(struct(model), params[singularize(resource)])

    case Repo.insert(changeset) do
      {:ok, _entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: admin_path(conn, :index, resource))
      {:error, changeset} ->
        #throw changeset
        render(conn, "new.html", changeset: changeset, columns: model.admin_fields, resource: resource)
    end
  end

  def edit(conn, %{"resource" => resource, "id" => id}) do
    model = models[resource]

    entry = Repo.get!(model, id)

    changeset = model.changeset(entry)

    render(conn, "edit.html", entry: entry, changeset: changeset, columns: model.admin_fields, resource: resource)
  end
end
