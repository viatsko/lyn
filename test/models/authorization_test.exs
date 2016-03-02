defmodule Lyn.AuthorizationTest do
  use Lyn.ModelCase

  alias Lyn.Authorization

  @valid_attrs %{expires_at: 42, provider: "some content", refresh_token: "some content", token: "some content", uid: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Authorization.changeset(%Authorization{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Authorization.changeset(%Authorization{}, @invalid_attrs)
    refute changeset.valid?
  end
end
