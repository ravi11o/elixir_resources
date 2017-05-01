defmodule ElixirResources.Newsletter do
  use ElixirResources.Web, :model

  schema "newsletters" do
    field :title, :string
    field :slug, :string
    field :cover, :string
    field :description, :string
    field :website, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :cover, :slug, :description, :website])
    |> validate_required([:title, :slug, :website])
    |> unique_constraint(:slug)
  end
end
