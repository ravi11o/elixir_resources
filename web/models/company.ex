defmodule ElixirResources.Company do
  use ElixirResources.Web, :model

  schema "companies" do
    field :title, :string
    field :slug, :string
    field :description, :string
    field :"cover", :string
    field :website, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :cover, :slug, :website])
    |> validate_required([:title, :slug, :website])
  end
end
