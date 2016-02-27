defmodule Lyn.Admin.ObjectTypeController do
  use Lyn.Web, :controller

  alias Lyn.Admin.ObjectType

  plug :put_layout, "admin.html"
  plug :scrub_params, "object_type" when action in [:create, :update]

  def index(conn, _params) do
    object_types = Repo.all(ObjectType)
    render(conn, "index.html", object_types: object_types)
  end

  def new(conn, _params) do
    changeset = ObjectType.changeset(%ObjectType{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"object_type" => object_type_params}) do
    changeset = ObjectType.changeset(%ObjectType{}, object_type_params)

    case Repo.insert(changeset) do
      {:ok, _object_type} ->
        conn
        |> put_flash(:info, "Object type created successfully.")
        |> redirect(to: object_type_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    object_type = Repo.get!(ObjectType, id)
    render(conn, "show.html", object_type: object_type)
  end

  def edit(conn, %{"id" => id}) do
    object_type = Repo.get!(ObjectType, id)
    changeset = ObjectType.changeset(object_type)
    render(conn, "edit.html", object_type: object_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "object_type" => object_type_params}) do
    object_type = Repo.get!(ObjectType, id)
    changeset = ObjectType.changeset(object_type, object_type_params)

    case Repo.update(changeset) do
      {:ok, object_type} ->
        conn
        |> put_flash(:info, "Object type updated successfully.")
        |> redirect(to: object_type_path(conn, :show, object_type))
      {:error, changeset} ->
        render(conn, "edit.html", object_type: object_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    object_type = Repo.get!(ObjectType, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(object_type)

    conn
    |> put_flash(:info, "Object type deleted successfully.")
    |> redirect(to: object_type_path(conn, :index))
  end
end
