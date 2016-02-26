defmodule Lyn.RoleChecker do
  alias Lyn.Repo
  alias Lyn.Role

  def is_admin?(user) do
    (role = Repo.get(Role, user.role_id)) && role.admin
  end
end
