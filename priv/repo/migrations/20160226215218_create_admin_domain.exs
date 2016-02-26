defmodule Lyn.Repo.Migrations.CreateAdmin.Domain do
  use Ecto.Migration

  def change do
    create table(:domains) do
      add :site_id, :integer
      add :name, :string
      add :sort_order, :integer

      timestamps
    end

  end
end
