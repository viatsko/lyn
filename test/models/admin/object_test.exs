defmodule Lyn.Admin.ObjectTest do
  use Lyn.ModelCase

  alias Lyn.Admin.Object

  @valid_attrs %{cache_time: 42, full_path: "some content", is_published: true, is_show_in_menu: true, is_show_on_site_map: true, nesting: 42, object_type_id: 42, parent_id: 42, path: "some content", site_id: 42, sort_order: 42, thread_id: 42, url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Object.changeset(%Object{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Object.changeset(%Object{}, @invalid_attrs)
    refute changeset.valid?
  end
end
