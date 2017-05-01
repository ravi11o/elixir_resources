defmodule ElixirResources.Job do
  use ElixirResources.Web, :model

  schema "jobs" do
    field :source, :string
    field :title, :string
    field :slug, :string
    field :cover, :string
    field :website, :string
    field :remote, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:source, :title, :cover, :slug, :website, :remote])
    |> validate_required([:source, :title, :website, :remote])
    |> unique_constraint(:slug)
  end
end
