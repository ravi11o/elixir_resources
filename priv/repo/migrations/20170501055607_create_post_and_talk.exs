defmodule ElixirResources.Repo.Migrations.CreatePostAndTalk do
  use Ecto.Migration

  def change do
    create table(:postandtalks) do
      add :resource, :string
      add :title, :string
      add :slug, :string
      add :description, :string
      add :writer, :string
      add :website, :string
      add :cover, :string
      add :price, :string
      add :tags, {:array, :string}

      timestamps()
    end
    create unique_index(:postandtalks, [:slug])

  end
end
