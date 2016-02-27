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
        label: "id"
      },
      site_id: %{
        label: "site_id"
      },
      name: %{
        label: "name"
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
