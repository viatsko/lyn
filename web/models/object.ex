defmodule Lyn.Object do
  use Lyn.Web, :model

  schema "objects" do
    field :sort_order, :integer, default: 0
    field :parent_id, :integer, default: 0
    field :thread_id, :integer, default: 0
    field :nesting, :integer, default: 0
    field :cache_time, :integer, default: 3600
    field :is_published, :boolean, default: false
    field :is_show_on_site_map, :boolean, default: false
    field :is_show_in_menu, :boolean, default: false
    field :path, :string
    field :url, :string
    field :full_path, :string

    belongs_to :object_type, Lyn.ObjectType
    belongs_to :site, Lyn.Site

    has_many :object_texts, Lyn.ObjectText

    has_many :children, Lyn.Object, foreign_key: :parent_id

    timestamps
  end

  def admin_outer_texts do
    %{
      :assoc => :object_texts,
      :model => Lyn.ObjectText
    }
  end

  def admin_fields do
    [
      id: %{
        label: "id",
        type: :integer
      },
      site_id: %{
        label: "site_id",
        type: :integer
      },
      parent_id: %{
        label: "parent_id",
        type: :integer
      },
      is_published: %{
        label: "is_published",
        type: :boolean
      },
      is_show_on_site_map: %{
        label: "is_show_on_site_map",
        type: :boolean
      },
      is_show_in_menu: %{
        label: "is_show_in_menu",
        type: :boolean
      },
      sort_order: %{
        label: "sort_order",
        type: :integer
      },
      path: %{
        label: "path",
        type: :string
      },
      url: %{
        label: "url",
        type: :string
      },
      full_path: %{
        label: "full_path",
        type: :string
      }
    ]
  end

  @required_fields ~w(parent_id site_id is_published is_show_on_site_map is_show_in_menu sort_order path url full_path object_texts)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
