defmodule ElixirResources.NewsletterController do
  use ElixirResources.Web, :controller

  alias ElixirResources.Newsletter
  alias ElixirResources.Query

  def index(conn, _params) do
    newsletters = Repo.all(Newsletter)
    render(conn, "index.html", newsletters: newsletters)
  end

  def new(conn, _params) do
    changeset = Newsletter.changeset(%Newsletter{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"newsletter" => newsletter_params}) do
    slug = 
      newsletter_params
      |> Map.get("title")
      |> Slugger.slugify_downcase
    newsletter_params = 
      if Query.check_slug(Newsletter, slug) do
        Map.put_new(newsletter_params, "slug", slug <> "-" <> UUID.uuid1())
      else
        Map.put_new(newsletter_params, "slug", slug)
      end

    changeset = Newsletter.changeset(%Newsletter{}, newsletter_params)

    case Repo.insert(changeset) do
      {:ok, _newsletter} ->
        conn
        |> put_flash(:info, "Newsletter created successfully.")
        |> redirect(to: newsletter_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    newsletter = Repo.get!(Newsletter, id)
    render(conn, "show.html", newsletter: newsletter)
  end

  def edit(conn, %{"id" => id}) do
    newsletter = Repo.get!(Newsletter, id)
    changeset = Newsletter.changeset(newsletter)
    render(conn, "edit.html", newsletter: newsletter, changeset: changeset)
  end

  def update(conn, %{"id" => id, "newsletter" => newsletter_params}) do
    newsletter = Repo.get!(Newsletter, id)
    changeset = Newsletter.changeset(newsletter, newsletter_params)

    case Repo.update(changeset) do
      {:ok, newsletter} ->
        conn
        |> put_flash(:info, "Newsletter updated successfully.")
        |> redirect(to: newsletter_path(conn, :show, newsletter))
      {:error, changeset} ->
        render(conn, "edit.html", newsletter: newsletter, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    newsletter = Repo.get!(Newsletter, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(newsletter)

    conn
    |> put_flash(:info, "Newsletter deleted successfully.")
    |> redirect(to: newsletter_path(conn, :index))
  end
end
