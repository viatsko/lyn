defmodule Lyn.Domain do
  use Lyn.Web, :model

  schema "domains" do
    field :site_id, :integer
    field :name, :string
    field :sort_order, :integer

    timestamps
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
      name: %{
        label: "name",
        type: :string
      },
      sort_order: %{
        label: "sort_order",
        type: :integer
      },
      inserted_at: %{
        label: "inserted_at",
        type: :datetime
      },
      updated_at: %{
        label: "updated_at",
        type: :datetime
      }
    ]
  end

  @required_fields ~w(site_id name sort_order)
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
