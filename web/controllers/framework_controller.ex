defmodule ElixirResources.FrameworkController do
  use ElixirResources.Web, :controller

  alias ElixirResources.Framework
  alias ElixirResources.Query

  def index(conn, _params) do
    frameworks = Repo.all(Framework)
    render(conn, "index.html", frameworks: frameworks)
  end

  def new(conn, _params) do
    changeset = Framework.changeset(%Framework{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"framework" => framework_params}) do
    slug = 
      framework_params
      |> Map.get("title")
      |> Slugger.slugify_downcase
    framework_params = 
      if Query.check_slug(Framework, slug) do
        Map.put_new(framework_params, "slug", slug <> "-" <> UUID.uuid1())
      else
        Map.put_new(framework_params, "slug", slug)
      end

    changeset = Framework.changeset(%Framework{}, framework_params)

    case Repo.insert(changeset) do
      {:ok, _framework} ->
        conn
        |> put_flash(:info, "Framework created successfully.")
        |> redirect(to: framework_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    framework = Repo.get!(Framework, id)
    render(conn, "show.html", framework: framework)
  end

  def edit(conn, %{"id" => id}) do
    framework = Repo.get!(Framework, id)
    changeset = Framework.changeset(framework)
    render(conn, "edit.html", framework: framework, changeset: changeset)
  end

  def update(conn, %{"id" => id, "framework" => framework_params}) do
    framework = Repo.get!(Framework, id)
    changeset = Framework.changeset(framework, framework_params)

    case Repo.update(changeset) do
      {:ok, framework} ->
        conn
        |> put_flash(:info, "Framework updated successfully.")
        |> redirect(to: framework_path(conn, :show, framework))
      {:error, changeset} ->
        render(conn, "edit.html", framework: framework, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    framework = Repo.get!(Framework, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(framework)

    conn
    |> put_flash(:info, "Framework deleted successfully.")
    |> redirect(to: framework_path(conn, :index))
  end
end
