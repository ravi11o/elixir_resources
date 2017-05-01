defmodule ElixirResources.Query do
  
  alias ElixirResources.User
  alias ElixirResources.Repo
  alias ElixirResources.Learning
  alias ElixirResources.PostAndTalk
  alias ElixirResources.Framework
  alias ElixirResources.Follow
  alias ElixirResources.Community
  alias ElixirResources.Job
  alias ElixirResources.Company
  alias ElixirResources.Application
  alias ElixirResources.Newsletter

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
      Community -> Repo.get_by(Community, slug: slug)
      Job -> Repo.get_by(Job, slug: slug)
      Company -> Repo.get_by(Company, slug: slug)
      Application -> Repo.get_by(Application, slug: slug)
      Newsletter -> Repo.get_by(Newsletter, slug: slug)

      _ -> "No Model found."
    end
  end
  
end