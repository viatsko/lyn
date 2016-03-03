defmodule Lyn.Factory do
  use ExMachina.Ecto, repo: Lyn.Repo

  alias Lyn.Role
  alias Lyn.User
  alias Lyn.Authorization
  alias Lyn.GuardianToken

  def factory(:role) do
    %Role{
      name: sequence(:name, &"Test Role #{&1}"),
      admin: false
    }
  end

  def factory(:user) do
    %User{
      username: sequence(:username, &"User #{&1}"),
      name: sequence(:name, &"User #{&1}"),
      email: sequence(:email, &"test#{&1}@test.com"),
      password: "test1234",
      password_confirmation: "test1234",
      password_digest: Comeonin.Bcrypt.hashpwsalt("test1234"),
      role: build(:role)
    }
  end

  def factory(:guardian_token) do
    %GuardianToken{
      jti: sequence(:jti, &"jti-#{&1}"),
    }
  end

  def factory(:authorization) do
    %Authorization{
      uid: sequence(:uid, &"uid-#{&1}"),
      user: build(:user),
      provider: "identity",
      token: Comeonin.Bcrypt.hashpwsalt("sekrit")
    }
  end

  def with_authorization(user, opts \\ []) do
    opts = opts ++ [user: user, uid: user.email]
    create(:authorization, opts)
  end
end
