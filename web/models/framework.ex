defmodule ElixirResources.Framework do
  use ElixirResources.Web, :model

  schema "frameworks" do
    field :title, :string
    field :slug, :string
    field :description, :string
    field :cover, :string
    field :website, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :slug, :cover, :website])
    |> validate_required([:title, :slug, :website])
    |> unique_constraint(:slug)
  end
end
