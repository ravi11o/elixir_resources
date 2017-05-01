defmodule ElixirResources.Query do
  
  alias ElixirResources.User
  alias ElixirResources.Repo
  alias ElixirResources.Learning
  alias ElixirResources.PostAndTalk
  alias ElixirResources.Framework
  alias ElixirResources.Follow

  def check_email(email) do
    Repo.get_by(User, email: email)
  end

  def insert_into_database(user) do
    changeset = User.changeset(%User{}, %{name: user["name"], email: user["email"], 
      picture: user["picture"]})
    Repo.insert!(changeset)
  end

  def check_slug(model, slug) do
    case model do
      Learning -> Repo.get_by(Learning, slug: slug)
      PostAndTalk -> Repo.get_by(PostAndTalk, slug: slug)
      Framework -> Repo.get_by(Framework, slug: slug)
      Follow -> Repo.get_by(Follow, slug: slug)
      _ -> "No Model found."
    end
  end
  
end