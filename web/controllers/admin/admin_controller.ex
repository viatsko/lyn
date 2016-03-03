defmodule Lyn.Admin.AdminController do
  use Lyn.Web, :admin_controller

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

  plug :assign_languages
  plug :object_tree

  def dashboard(conn, _params, current_user, _claims) do
    render(conn, "dashboard.html")
  end

  def index(conn, params, current_user, _claims) do
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

  def new(conn, params, current_user, _claims) do
    resource = params["resource"]

    case Map.has_key?(params, "site_id") do
      true ->
        site_id = params["site_id"]

        model = models[resource]

        model_map = generate_model_map(conn, model, site_id)

        changeset = model.changeset(model_map)

        render(conn, "new.html", changeset: changeset, model: model, resource: resource)
      _ ->
        redirect(conn, to: admin_admin_path(conn, :index, resource))
    end
  end

  def create(conn, params, current_user, _claims) do
    resource = params["resource"]

    entry_params = params[singularize(resource)]

    model = models[resource]

    changeset = model.changeset(struct(model), entry_params)

    case Repo.insert(changeset) do
      {:ok, _entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: admin_admin_path(conn, :index, resource))
      {:error, changeset} ->
        #throw changeset
        render(conn, "new.html", changeset: changeset, model: model, resource: resource)
    end
  end

  def edit(conn, %{"resource" => resource, "id" => id}, current_user, _claims) do
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

  def update(conn, params, current_user, _claims) do
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
        |> redirect(to: admin_admin_path(conn, :edit, resource, entry.id))
      {:error, changeset} ->
        render(conn, "edit.html", entry: entry, changeset: changeset, model: model, resource: resource)
    end
  end

  def delete(conn, %{"resource" => resource, "id" => id}, current_user, _claims) do
    model = models[resource]

    entry = Repo.get!(model, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: admin_admin_path(conn, :index, resource))
  end

  defp assign_languages(conn, _params) do
    query = from(l in Language, order_by: l.sort_order)

    languages = Repo.all(query)

    assign(conn, :languages, languages)
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
        changeset = Object.changeset(struct(Object), %{
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

  defp generate_model_map(conn, model) do
    generate_model_map(conn, model, 0)
  end

  # Generates specified model and checks if it has admin_outer_texts
  # property. If so, it will fetch outer_texts by the number of languages
  # specified.
  defp generate_model_map(conn, model, site_id) do
    case function_exported?(model, :admin_outer_texts, 0) do
      true ->
        outer_texts = for language <- conn.assigns[:languages] do
          struct(model.admin_outer_texts.model, %{
            :language_id => language.id
          })
        end

        struct(model, %{
          model.admin_outer_texts.assoc => outer_texts,
          :site_id => site_id
        })
      _ ->
        struct(model)
    end
  end
end
