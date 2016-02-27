defmodule Lyn.Language do
  use Lyn.Web, :model

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
        label: "id"
      },
      name: %{
        label: "name"
      },
      abbr: %{
        label: "abbr"
      },
      charset: %{
        label: "charset"
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

  @required_fields ~w(sort_order name abbr charset)
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
