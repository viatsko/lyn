defmodule Lyn.Repo.Migrations.CreateAdmin.Site do
  use Ecto.Migration

  def change do
    create table(:sites) do
      add :sort_order, :integer
      add :cache_time, :integer
      add :language_id, :integer
      add :name, :string
      add :domain_id, :integer

      timestamps
    end

  end
end
