defmodule Lyn.Repo.Migrations.CreateFeature do
  use Ecto.Migration

  def change do
    create table(:features) do
      add :name, :string
      add :active, :boolean, default: false

      timestamps
    end

  end
end
