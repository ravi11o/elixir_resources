defmodule ElixirResources.User do
  use ElixirResources.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :is_admin, :boolean, default: false
    field :picture, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :is_admin, :picture])
    |> validate_required([:name, :email, :is_admin])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
  end
end
