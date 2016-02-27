defmodule Lyn.ObjectText do
  use Lyn.Web, :model

  schema "object_texts" do
    field :language_id, :integer
    field :object_id, :integer
    field :name, :string
    field :window_name, :string
    field :document_name, :string
    field :meta_keywords, :string
    field :meta_description, :string

    timestamps
  end

  @required_fields ~w(language_id object_id name window_name document_name meta_keywords meta_description)
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
