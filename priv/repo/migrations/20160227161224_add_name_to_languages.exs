defmodule Lyn.Repo.Migrations.AddNameToLanguages do
  use Ecto.Migration

  def change do
    alter table(:languages) do
      add :name, :string
    end
  end
end
