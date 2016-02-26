defmodule Lyn.TestHelper do
  alias Lyn.Repo
  alias Lyn.User
  alias Lyn.Role

  import Ecto, only: [build_assoc: 2]

  def create_role(%{name: name, admin: admin}) do
    Role.changeset(%Role{}, %{name: name, admin: admin})
    |> Repo.insert
  end

  def create_user(role, %{email: email, username: username, password: password, password_confirmation: password_confirmation}) do
    role
    |> build_assoc(:users)
    |> User.changeset(%{email: email, username: username, password: password, password_confirmation: password_confirmation})
    |> Repo.insert
  end
end
