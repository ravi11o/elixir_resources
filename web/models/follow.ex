defmodule ElixirResources.Follow do
  use ElixirResources.Web, :model

  schema "follow" do
    field :resource, :string
    field :name, :string
    field :slug, :string
    field :cover, :string
    field :website, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:resource, :name, :cover, :slug, :website])
    |> validate_required([:resource, :name, :slug, :website])
    |> unique_constraint(:slug)
  end
end
