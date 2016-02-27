defmodule Lyn.LanguageTest do
  use Lyn.ModelCase

  alias Lyn.Language

  @valid_attrs %{name: "some content", abbr: "some content", charset: "some content", sort_order: 42}
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
