defmodule Lyn.Repo.Migrations.CreateAdmin.Role do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :admin, :boolean, default: false

      timestamps
    end

  end
end
