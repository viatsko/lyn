defmodule Lyn.ObjectType do
  use Lyn.Web, :model

  schema "object_types" do
    field :sort_order, :integer
    field :is_fake, :boolean, default: false
    field :abbr, :string
    field :name, :string

    timestamps
  end

  @required_fields ~w(sort_order is_fake abbr name)
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
