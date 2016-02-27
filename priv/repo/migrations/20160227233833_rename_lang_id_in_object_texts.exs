defmodule Lyn.Repo.Migrations.RenameLangIdInObjectTexts do
  use Ecto.Migration

  def change do
    alter table(:object_texts) do
      remove :lang_id
      add :language_id, :integer
    end
  end
end
