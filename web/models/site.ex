defmodule Lyn.Site do
  use Lyn.Web, :model

  schema "sites" do
    field :sort_order, :integer
    field :cache_time, :integer
    field :language_id, :integer
    field :name, :string
    field :domain_id, :integer

    timestamps
  end

  def admin_fields do
    [
      id: %{
        label: "id"
      },
      language_id: %{
        label: "language_id"
      },
      domain_id: %{
        label: "domain_id"
      },
      name: %{
        label: "name"
      },
      cache_time: %{
        label: "cache_time"
      },
      sort_order: %{
        label: "sort_order"
      },
      inserted_at: %{
        label: "inserted_at"
      },
      updated_at: %{
        label: "updated_at"
      }
    ]
  end

  @required_fields ~w(sort_order cache_time language_id name)
  @optional_fields ~w(domain_id)

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
