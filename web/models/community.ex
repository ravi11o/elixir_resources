defmodule ElixirResources.Community do
  use ElixirResources.Web, :model

  schema "communities" do
    field :title, :string
    field :slug, :string
    field :social_type, :string
    field :description, :string
    field :website, :string
    field :cover, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :social_type, :slug, :description, :website, :cover])
    |> validate_required([:title, :social_type, :slug, :website])
    |> unique_constraint(:slug)
  end
end
