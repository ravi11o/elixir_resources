defmodule ElixirResources.Repo.Migrations.CreateCommunity do
  use Ecto.Migration

  def change do
    create table(:communities) do
      add :title, :string
      add :slug, :string
      add :social_type, :string
      add :description, :string
      add :website, :string
      add :cover, :string

      timestamps()
    end
    create unique_index(:communities, [:slug])
  end
end
