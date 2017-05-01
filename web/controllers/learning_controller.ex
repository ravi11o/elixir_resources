defmodule ElixirResources.LearningController do
  use ElixirResources.Web, :controller

  alias ElixirResources.Learning
  alias ElixirResources.Query

  def index(conn, _params) do
    learnings = Repo.all(Learning)
    render(conn, "index.html", learnings: learnings)
  end

  def new(conn, _params) do
    changeset = Learning.changeset(%Learning{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"learning" => learning_params}) do
    slug = 
      learning_params
      |> Map.get("title")
      |> Slugger.slugify_downcase
    learning_params = 
      if Query.check_slug(Learning, slug) do
        Map.put_new(learning_params, "slug", slug <> "-" <> UUID.uuid1())
      else
        Map.put_new(learning_params, "slug", slug)
      end

    changeset = Learning.changeset(%Learning{}, learning_params)

    case Repo.insert(changeset) do
      {:ok, _learning} ->
        conn
        |> put_flash(:info, "Learning created successfully.")
        |> redirect(to: learning_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    learning = Repo.get!(Learning, id)
    render(conn, "show.html", learning: learning)
  end

  def edit(conn, %{"id" => id}) do
    learning = Repo.get!(Learning, id)
    changeset = Learning.changeset(learning)
    render(conn, "edit.html", learning: learning, changeset: changeset)
  end

  def update(conn, %{"id" => id, "learning" => learning_params}) do
    IO.inspect(learning_params)
    learning = Repo.get!(Learning, id)
    changeset = Learning.changeset(learning, learning_params)

    case Repo.update(changeset) do
      {:ok, learning} ->
        conn
        |> put_flash(:info, "Learning updated successfully.")
        |> redirect(to: learning_path(conn, :show, learning))
      {:error, changeset} ->
        render(conn, "edit.html", learning: learning, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    learning = Repo.get!(Learning, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(learning)

    conn
    |> put_flash(:info, "Learning deleted successfully.")
    |> redirect(to: learning_path(conn, :index))
  end
end
