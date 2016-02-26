defmodule Lyn.UserView do
  use Lyn.Web, :view

  def roles_for_select(roles) do
    roles
    |> Enum.map(&["#{&1.name}": &1.id])
    |> List.flatten
  end
end
