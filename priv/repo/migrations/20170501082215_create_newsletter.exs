defmodule ElixirResources.Repo.Migrations.CreateNewsletter do
  use Ecto.Migration

  def change do
    create table(:newsletters) do
      add :title, :string
      add :slug, :string
      add :cover, :string
      add :description, :string
      add :website, :string

      timestamps()
    end
    create unique_index(:newsletters, [:slug])
  end
end
