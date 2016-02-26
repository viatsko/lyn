defmodule Lyn.Factory do
  use ExMachina.Ecto, repo: Lyn.Repo

  alias Lyn.Role
  alias Lyn.User

  def factory(:role) do
    %Role{
      name: sequence(:name, &"Test Role #{&1}"),
      admin: false
    }
  end

  def factory(:user) do
    %User{
      username: sequence(:username, &"User #{&1}"),
      email: sequence(:email, &"test#{&1}@test.com"),
      password: "test1234",
      password_confirmation: "test1234",
      password_digest: Comeonin.Bcrypt.hashpwsalt("test1234"),
      role: build(:role)
    }
  end
end
