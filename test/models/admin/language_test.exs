defmodule Lyn.Admin.LanguageTest do
  use Lyn.ModelCase

  alias Lyn.Admin.Language

  @valid_attrs %{abbr: "some content", charset: "some content", sort_order: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Language.changeset(%Language{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Language.changeset(%Language{}, @invalid_attrs)
    refute changeset.valid?
  end
end
