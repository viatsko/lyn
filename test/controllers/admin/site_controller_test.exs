defmodule Lyn.Admin.SiteControllerTest do
  use Lyn.ConnCase

  alias Lyn.Admin.Site
  @valid_attrs %{cache_time: 42, domain_id: 42, language_id: 42, name: "some content", sort_order: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, site_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing sites"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, site_path(conn, :new)
    assert html_response(conn, 200) =~ "New site"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, site_path(conn, :create), site: @valid_attrs
    assert redirected_to(conn) == site_path(conn, :index)
    assert Repo.get_by(Site, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, site_path(conn, :create), site: @invalid_attrs
    assert html_response(conn, 200) =~ "New site"
  end

  test "shows chosen resource", %{conn: conn} do
    site = Repo.insert! %Site{}
    conn = get conn, site_path(conn, :show, site)
    assert html_response(conn, 200) =~ "Show site"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, site_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    site = Repo.insert! %Site{}
    conn = get conn, site_path(conn, :edit, site)
    assert html_response(conn, 200) =~ "Edit site"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    site = Repo.insert! %Site{}
    conn = put conn, site_path(conn, :update, site), site: @valid_attrs
    assert redirected_to(conn) == site_path(conn, :show, site)
    assert Repo.get_by(Site, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    site = Repo.insert! %Site{}
    conn = put conn, site_path(conn, :update, site), site: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit site"
  end

  test "deletes chosen resource", %{conn: conn} do
    site = Repo.insert! %Site{}
    conn = delete conn, site_path(conn, :delete, site)
    assert redirected_to(conn) == site_path(conn, :index)
    refute Repo.get(Site, site.id)
  end
end
