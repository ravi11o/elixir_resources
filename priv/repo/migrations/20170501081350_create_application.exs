defmodule ElixirResources.Repo.Migrations.CreateApplication do
  use Ecto.Migration

  def change do
    create table(:applications) do
      add :title, :string
      add :slug, :string
      add :cover, :string
      add :description, :string
      add :website, :string

      timestamps()
    end
    create unique_index(:applications, [:slug])
  end
end
