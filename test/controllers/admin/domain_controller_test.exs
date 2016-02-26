defmodule Lyn.Admin.DomainControllerTest do
  use Lyn.ConnCase

  alias Lyn.Admin.Domain
  @valid_attrs %{name: "some content", site_id: 42, sort_order: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, domain_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing domains"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, domain_path(conn, :new)
    assert html_response(conn, 200) =~ "New domain"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, domain_path(conn, :create), domain: @valid_attrs
    assert redirected_to(conn) == domain_path(conn, :index)
    assert Repo.get_by(Domain, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, domain_path(conn, :create), domain: @invalid_attrs
    assert html_response(conn, 200) =~ "New domain"
  end

  test "shows chosen resource", %{conn: conn} do
    domain = Repo.insert! %Domain{}
    conn = get conn, domain_path(conn, :show, domain)
    assert html_response(conn, 200) =~ "Show domain"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, domain_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    domain = Repo.insert! %Domain{}
    conn = get conn, domain_path(conn, :edit, domain)
    assert html_response(conn, 200) =~ "Edit domain"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    domain = Repo.insert! %Domain{}
    conn = put conn, domain_path(conn, :update, domain), domain: @valid_attrs
    assert redirected_to(conn) == domain_path(conn, :show, domain)
    assert Repo.get_by(Domain, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    domain = Repo.insert! %Domain{}
    conn = put conn, domain_path(conn, :update, domain), domain: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit domain"
  end

  test "deletes chosen resource", %{conn: conn} do
    domain = Repo.insert! %Domain{}
    conn = delete conn, domain_path(conn, :delete, domain)
    assert redirected_to(conn) == domain_path(conn, :index)
    refute Repo.get(Domain, domain.id)
  end
end
