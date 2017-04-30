defmodule ElixirResources.Repo.Migrations.CreateLearning do
  use Ecto.Migration

  def change do
    create table(:learnings) do
      add :resource, :string
      add :title, :string
      add :cover, :string
      add :description, :text
      add :slug, :string
      add :website, :string
      add :author, :string
      add :price, :string

      timestamps()
    end

    create unique_index(:learnings, [:slug])

  end
end
