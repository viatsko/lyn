defmodule Lyn.User do
  use Lyn.Web, :model

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  alias Lyn.Repo

  schema "users" do
    field :username, :string
    field :name, :string
    field :email, :string
    field :password_digest, :string
    field :avatar, :string
    field :is_admin, :boolean

    belongs_to :role, Lyn.Role

    timestamps

    # Virtual Fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  def admin_fields do
    [
      id: %{
        label: "id",
        type: :integer
      },
      name: %{
        label: "full name",
        type: :string
      },
      username: %{
        label: "username",
        type: :string
      },
      avatar: %{
        label: "avatar",
        type: :string
      },
      email: %{
        label: "email",
        type: :string
      },
      is_admin: %{
        label: "is_admin",
        type: :boolean
      },
      role_id: %{
        label: "role_id",
        type: :integer
      }
    ]
  end

  @required_fields ~w(username email password password_confirmation role_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.
  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> hash_password
    |> validate_confirmation(:password, message: "does not match password!")
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 4)
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:password_digest, hashpwsalt(password))
    else
      changeset
    end
  end

  def make_admin!(user) do
    user
    |> cast(%{is_admin: true}, ~w(), ~w(is_admin))
    |> Repo.update!
  end
end
