defmodule ElixirResources.Query do
  
  alias ElixirResources.User
  alias ElixirResources.Repo
  alias ElixirResources.Learning

  def check_email(email) do
    Repo.get_by(User, email: email)
  end

  def insert_into_database(user) do
    changeset = User.changeset(%User{}, %{name: user["name"], email: user["email"], 
      picture: user["picture"]})
    Repo.insert!(changeset)
  end

  def check_slug(slug) do
    Repo.get_by(Learning, slug: slug)
  end
end