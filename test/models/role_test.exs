defmodule Lyn.RoleTest do
  use Lyn.ModelCase

  alias Lyn.Role

  @valid_attrs %{admin: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Role.changeset(%Role{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Role.changeset(%Role{}, @invalid_attrs)
    refute changeset.valid?
  end
end
