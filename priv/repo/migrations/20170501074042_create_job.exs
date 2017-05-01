defmodule ElixirResources.Repo.Migrations.CreateJob do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :source, :string
      add :title, :string
      add :slug, :string
      add :cover, :string
      add :website, :string
      add :remote, :boolean, default: false, null: false

      timestamps()
    end
    create unique_index(:jobs, [:slug])
  end
end
