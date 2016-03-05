defmodule Lyn.FeatureTest do
  use Lyn.ModelCase

  alias Lyn.Feature

  @valid_attrs %{active: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Feature.changeset(%Feature{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Feature.changeset(%Feature{}, @invalid_attrs)
    refute changeset.valid?
  end
end
