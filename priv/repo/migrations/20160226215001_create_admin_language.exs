defmodule Lyn.Repo.Migrations.CreateAdmin.Language do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :sort_order, :integer
      add :abbr, :string
      add :charset, :string

      timestamps
    end

  end
end
