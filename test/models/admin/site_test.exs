defmodule Lyn.Admin.SiteTest do
  use Lyn.ModelCase

  alias Lyn.Admin.Site

  @valid_attrs %{cache_time: 42, domain_id: 42, language_id: 42, name: "some content", sort_order: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Site.changeset(%Site{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Site.changeset(%Site{}, @invalid_attrs)
    refute changeset.valid?
  end
end
