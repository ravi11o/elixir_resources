defmodule ElixirResources.Repo.Migrations.CreateFollow do
  use Ecto.Migration

  def change do
    create table(:follow) do
      add :resource, :string
      add :name, :string
      add :slug, :string
      add :cover, :string
      add :website, :string

      timestamps()
    end
    create unique_index(:follow, [:slug])
  end
end
