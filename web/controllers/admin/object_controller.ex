defmodule Lyn.Admin.ObjectController do
  use Lyn.Web, :controller

  alias Lyn.Admin.Object

  plug :put_layout, "admin.html"
  plug :scrub_params, "object" when action in [:create, :update]

  def index(conn, _params) do
    objects = Repo.all(Object)
    render(conn, "index.html", objects: objects)
  end

  def new(conn, _params) do
    changeset = Object.changeset(%Object{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"object" => object_params}) do
    changeset = Object.changeset(%Object{}, object_params)

    case Repo.insert(changeset) do
      {:ok, _object} ->
        conn
        |> put_flash(:info, "Object created successfully.")
        |> redirect(to: object_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    object = Repo.get!(Object, id)
    render(conn, "show.html", object: object)
  end

  def edit(conn, %{"id" => id}) do
    object = Repo.get!(Object, id)
    changeset = Object.changeset(object)
    render(conn, "edit.html", object: object, changeset: changeset)
  end

  def update(conn, %{"id" => id, "object" => object_params}) do
    object = Repo.get!(Object, id)
    changeset = Object.changeset(object, object_params)

    case Repo.update(changeset) do
      {:ok, object} ->
        conn
        |> put_flash(:info, "Object updated successfully.")
        |> redirect(to: object_path(conn, :show, object))
      {:error, changeset} ->
        render(conn, "edit.html", object: object, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    object = Repo.get!(Object, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(object)

    conn
    |> put_flash(:info, "Object deleted successfully.")
    |> redirect(to: object_path(conn, :index))
  end
end
