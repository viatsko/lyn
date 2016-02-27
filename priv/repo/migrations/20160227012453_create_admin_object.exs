defmodule Lyn.Repo.Migrations.CreateAdmin.Object do
  use Ecto.Migration

  def change do
    create table(:objects) do
      add :sort_order, :integer
      add :parent_id, :integer
      add :thread_id, :integer
      add :site_id, :integer
      add :object_type_id, :integer
      add :nesting, :integer
      add :cache_time, :integer
      add :is_published, :boolean, default: false
      add :is_show_on_site_map, :boolean, default: false
      add :is_show_in_menu, :boolean, default: false
      add :path, :string
      add :url, :string
      add :full_path, :string

      timestamps
    end

  end
end
