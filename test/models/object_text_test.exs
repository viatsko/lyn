defmodule Lyn.ObjectTextTest do
  use Lyn.ModelCase

  alias Lyn.ObjectText

  @valid_attrs %{document_name: "some content", lang_id: 42, meta_description: "some content", meta_keywords: "some content", name: "some content", object_id: 42, window_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ObjectText.changeset(%ObjectText{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ObjectText.changeset(%ObjectText{}, @invalid_attrs)
    refute changeset.valid?
  end
end
