defmodule Lyn.Feature do
  use Lyn.Web, :model

  schema "features" do
    field :name, :string
    field :active, :boolean, default: false

    timestamps
  end

  def admin_fields do
    [
      id: %{
        label: "id",
        type: :integer
      },
      name: %{
        label: "name",
        type: :string
      },
      active: %{
        label: "active",
        type: :boolean
      }
    ]
  end

  @required_fields ~w(name active)
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
