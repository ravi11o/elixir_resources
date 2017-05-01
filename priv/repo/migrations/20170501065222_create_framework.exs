defmodule ElixirResources.Repo.Migrations.CreateFramework do
  use Ecto.Migration

  def change do
    create table(:frameworks) do
      add :title, :string
      add :description, :string
      add :slug, :string
      add :cover, :string
      add :website, :string

      timestamps()
    end
    create unique_index(:frameworks, [:slug])
  end
end
