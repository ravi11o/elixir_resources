defmodule ElixirResources.Repo.Migrations.CreateCompany do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :title, :string
      add :slug, :string
      add :description, :string
      add :cover, :string
      add :website, :string

      timestamps()
    end
    create unique_index(:companies, [:slug])
  end
end
