defmodule ElixirResources.PostAndTalk do
  use ElixirResources.Web, :model

  schema "postandtalks" do
    field :resource, :string
    field :title, :string
    field :slug, :string
    field :writer, :string
    field :description, :string
    field :website, :string
    field :cover, :string
    field :price, :string
    field :tags, {:array, :string}

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:resource, :title, :slug, :description, :writer, :website, :cover, :price, :tags])
    |> validate_required([:resource, :title, :slug, :website, :price])
    |> validate_inclusion(:resource, ["post", "talk"])
    |> unique_constraint(:slug)
    |> validate_inclusion(:price, ["free", "paid"])
  end
end
