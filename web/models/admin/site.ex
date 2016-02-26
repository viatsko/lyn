defmodule Lyn.Admin.Site do
  use Lyn.Web, :model

  schema "sites" do
    field :sort_order, :integer
    field :cache_time, :integer
    field :language_id, :integer
    field :name, :string
    field :domain_id, :integer

    timestamps
  end

  @required_fields ~w(sort_order cache_time language_id name domain_id)
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
