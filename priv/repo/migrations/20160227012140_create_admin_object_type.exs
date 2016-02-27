defmodule Lyn.Repo.Migrations.CreateAdmin.ObjectType do
  use Ecto.Migration

  def change do
    create table(:object_types) do
      add :sort_order, :integer
      add :is_fake, :boolean, default: false
      add :abbr, :string
      add :name, :string

      timestamps
    end

  end
end
