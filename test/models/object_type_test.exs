defmodule Lyn.Admin.ObjectTypeTest do
  use Lyn.ModelCase

  alias Lyn.ObjectType

  @valid_attrs %{abbr: "some content", is_fake: true, name: "some content", sort_order: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ObjectType.changeset(%ObjectType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ObjectType.changeset(%ObjectType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
