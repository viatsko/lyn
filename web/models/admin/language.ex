defmodule Lyn.Admin.Language do
  use Lyn.Web, :model

  schema "languages" do
    field :sort_order, :integer
    field :abbr, :string
    field :charset, :string

    timestamps
  end

  @required_fields ~w(sort_order abbr charset)
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
