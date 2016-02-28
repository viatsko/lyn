defmodule Lyn.Language do
  use Lyn.Web, :model

  import Lyn.AdminModel

  schema "languages" do
    field :sort_order, :integer
    field :name, :string
    field :abbr, :string
    field :charset, :string

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
      abbr: %{
        label: "abbr",
        type: :string
      },
      charset: %{
        label: "charset",
        type: :string
      },
      sort_order: %{
        label: "sort_order",
        type: :integer
      }
    ]
  end

  @required_fields ~w(name abbr charset)
  @optional_fields ~w(sort_order)

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
