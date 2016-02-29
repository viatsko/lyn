defmodule Lyn.ObjectText do
  use Lyn.Web, :model

  schema "object_texts" do
    field :name, :string
    field :window_name, :string
    field :document_name, :string
    field :meta_keywords, :string
    field :meta_description, :string

    belongs_to :language, Lyn.Language
    belongs_to :object, Lyn.Object

    timestamps
  end

  def admin_fields do
    [
      id: %{
        label: "id",
        type: :integer
      },
      language_id: %{
        label: "language_id",
        type: :hidden
      },
      name: %{
        label: "name",
        type: :string
      },
      window_name: %{
        label: "window_name",
        type: :string
      },
      document_name: %{
        label: "document_name",
        type: :string
      },
      meta_keywords: %{
        label: "meta_keywords",
        type: :string
      },
      meta_description: %{
        label: "meta_description",
        type: :string
      }
    ]
  end

  @required_fields ~w(language_id name window_name document_name meta_keywords meta_description)
  @optional_fields ~w(object_id)

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
