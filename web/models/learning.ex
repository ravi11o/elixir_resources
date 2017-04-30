defmodule ElixirResources.Learning do
  use ElixirResources.Web, :model

  schema "learnings" do
    field :resource, :string
    field :title, :string
    field :cover, :string
    field :description, :string
    field :slug, :string
    field :website, :string
    field :author, :string
    field :price, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:resource, :title, :cover, :description, :slug, :website, :author, :price])
    |> validate_required([:resource, :title, :website, :price])
    |> validate_inclusion(:resource, ["book", "video", "practice"])
    |> validate_inclusion(:price, ["free", "paid"])
  end
end
