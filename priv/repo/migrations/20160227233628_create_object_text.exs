defmodule Lyn.Repo.Migrations.CreateObjectText do
  use Ecto.Migration

  def change do
    create table(:object_texts) do
      add :lang_id, :integer
      add :object_id, :integer
      add :name, :string
      add :window_name, :string
      add :document_name, :string
      add :meta_keywords, :text
      add :meta_description, :text

      timestamps
    end

  end
end
