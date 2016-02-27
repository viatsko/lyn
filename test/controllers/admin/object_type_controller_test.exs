defmodule Lyn.Admin.ObjectTypeControllerTest do
  use Lyn.ConnCase

  alias Lyn.Admin.ObjectType
  @valid_attrs %{abbr: "some content", is_fake: true, name: "some content", sort_order: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, object_type_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing object types"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, object_type_path(conn, :new)
    assert html_response(conn, 200) =~ "New object type"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, object_type_path(conn, :create), object_type: @valid_attrs
    assert redirected_to(conn) == object_type_path(conn, :index)
    assert Repo.get_by(ObjectType, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, object_type_path(conn, :create), object_type: @invalid_attrs
    assert html_response(conn, 200) =~ "New object type"
  end

  test "shows chosen resource", %{conn: conn} do
    object_type = Repo.insert! %ObjectType{}
    conn = get conn, object_type_path(conn, :show, object_type)
    assert html_response(conn, 200) =~ "Show object type"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, object_type_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    object_type = Repo.insert! %ObjectType{}
    conn = get conn, object_type_path(conn, :edit, object_type)
    assert html_response(conn, 200) =~ "Edit object type"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    object_type = Repo.insert! %ObjectType{}
    conn = put conn, object_type_path(conn, :update, object_type), object_type: @valid_attrs
    assert redirected_to(conn) == object_type_path(conn, :show, object_type)
    assert Repo.get_by(ObjectType, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    object_type = Repo.insert! %ObjectType{}
    conn = put conn, object_type_path(conn, :update, object_type), object_type: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit object type"
  end

  test "deletes chosen resource", %{conn: conn} do
    object_type = Repo.insert! %ObjectType{}
    conn = delete conn, object_type_path(conn, :delete, object_type)
    assert redirected_to(conn) == object_type_path(conn, :index)
    refute Repo.get(ObjectType, object_type.id)
  end
end
