defmodule Lyn.AdminController do
  use Lyn.Web, :controller

  import Inflex

  alias Lyn.Domain
  alias Lyn.Language
  alias Lyn.Object
  alias Lyn.ObjectType
  alias Lyn.Site
  alias Lyn.User

  def models, do: %{
    "domains" => Domain,
    "languages" => Language,
    "objects" => Object,
    "object_types" => ObjectType,
    "sites" => Site,
    "users" => User
  }

  plug :put_layout, "admin.html"
  plug :assign_languages
  plug :object_tree

  def dashboard(conn, _params) do
    render(conn, "dashboard.html")
  end

  def index(conn, params) do
    resource = params["resource"]

    model = models[resource]

    case model do
      nil ->
        render(conn, "dashboard.html")
      model ->
        sort = String.to_atom(params["sort"] || "id")

        direction = params["direction"] || "asc"

        entries = case conn.assigns[:entries] do
          nil ->
            query = case direction do
              "asc" ->
                from(m in model, order_by: [asc: ^sort])
              _ ->
                from(m in model, order_by: [desc: ^sort])
            end

            Repo.all(query)
          entries ->
            entries
        end

        columns = Enum.drop(Map.keys(model.__struct__), 2)

        render(conn, "index.html", entries: entries,
                                   columns: model.admin_fields,
                                   model: model,
                                   resource: resource,
                                   sort: sort,
                                   direction: direction)
    end
  end

  def new(conn, %{"resource" => resource}) do
    model = models[resource]

    model_map = struct(model)

    changeset = model.changeset(model_map)

    render(conn, "new.html", changeset: changeset, model: model, resource: resource)
  end

  def create(conn, params) do
    resource = params["resource"]

    entry_params = params[singularize(resource)]

    model = models[resource]

    changeset = model.changeset(struct(model), entry_params)

    case Repo.insert(changeset) do
      {:ok, _entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: admin_path(conn, :index, resource))
      {:error, changeset} ->
        #throw changeset
        render(conn, "new.html", changeset: changeset, model: model, resource: resource)
    end
  end

  def edit(conn, %{"resource" => resource, "id" => id}) do
    model = models[resource]

    entry = case function_exported?(model, :admin_outer_texts, 0) do
      true ->
        Repo.get!(model, id)
        |> Repo.preload(model.admin_outer_texts[:assoc])
      _ ->
        Repo.get!(model, id)
    end

    changeset = model.changeset(entry)

    render(conn, "edit.html", entry: entry, changeset: changeset, model: model, resource: resource)
  end

  def update(conn, params) do
    id = params["id"]

    resource = params["resource"]

    entry_params = params[singularize(resource)]

    model = models[resource]

    entry = case Kernel.function_exported?(model, :admin_outer_texts, 0) do
      true ->
        Repo.get!(model, id)
        |> Repo.preload(model.admin_outer_texts[:assoc])
      _ ->
        Repo.get!(model, id)
    end

    changeset = model.changeset(entry, entry_params)

    case Repo.update(changeset) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry updated successfully.")
        |> redirect(to: admin_path(conn, :edit, resource, entry.id))
      {:error, changeset} ->
        render(conn, "edit.html", entry: entry, changeset: changeset, model: model, resource: resource)
    end
  end

  def delete(conn, %{"resource" => resource, "id" => id}) do
    model = models[resource]

    entry = Repo.get!(model, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: admin_path(conn, :index, resource))
  end

  defp assign_languages(conn, _params) do
    assign(conn, :languages, Repo.all(Language))
  end

  defp object_tree(conn, _params) do
    # Fetching all sites
    sites = Repo.all(Site)

    # Fetching all objects to build a tree
    objects = Repo.all(Object)

    object_tree_list = for site <- sites do
      current = Enum.filter(objects, fn(x) -> x.site_id === site.id end)

      current_size = Enum.count(current)

      # If we don't have objects in current site,
      # create one
      if current_size === 0 do
        changeset = Object.changeset(%Object{}, %{
          "site_id" => site.id,
          "parent_id" => 0,
          "is_published" => true,
          "is_show_on_site_map" => true,
          "is_show_in_menu" => true,
          "sort_order" => 0,
          "path" => "/",
          "url" => "/",
          "full_path" => "/"
        })

        case Repo.insert(changeset) do
          {:ok, entry} ->
            current = [entry]
        end
      end

      Map.put(site, :children, current)
    end

    # Throwing object_tree to frontend
    assign(conn, :object_tree, object_tree_list)
  end
end
