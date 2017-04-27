defmodule ElixirResources.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :is_admin, :boolean, default: false, null: false
      add :picture, :string

      timestamps()
    end

  end
end
