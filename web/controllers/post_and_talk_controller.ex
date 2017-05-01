defmodule ElixirResources.PostAndTalkController do
  use ElixirResources.Web, :controller

  alias ElixirResources.PostAndTalk
  alias ElixirResources.Query

  def index(conn, _params) do
    postandtalks = Repo.all(PostAndTalk)
    render(conn, "index.html", postandtalks: postandtalks)
  end

  def new(conn, _params) do
    changeset = PostAndTalk.changeset(%PostAndTalk{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post_and_talk" => post_and_talk_params}) do
    slug = 
      post_and_talk_params
      |> Map.get("title")
      |> Slugger.slugify_downcase

    post_and_talk_params = 
      if Query.check_slug(PostAndTalk, slug) do
        Map.put_new(post_and_talk_params, "slug", slug <> "-" <> UUID.uuid1())
      else
        Map.put_new(post_and_talk_params, "slug", slug)
      end

    changeset = PostAndTalk.changeset(%PostAndTalk{}, post_and_talk_params)

    case Repo.insert(changeset) do
      {:ok, _post_and_talk} ->
        conn
        |> put_flash(:info, "Post and talk created successfully.")
        |> redirect(to: post_and_talk_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post_and_talk = Repo.get!(PostAndTalk, id)
    render(conn, "show.html", post_and_talk: post_and_talk)
  end

  def edit(conn, %{"id" => id}) do
    post_and_talk = Repo.get!(PostAndTalk, id)
    changeset = PostAndTalk.changeset(post_and_talk)
    render(conn, "edit.html", post_and_talk: post_and_talk, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post_and_talk" => post_and_talk_params}) do
    post_and_talk = Repo.get!(PostAndTalk, id)
    changeset = PostAndTalk.changeset(post_and_talk, post_and_talk_params)

    case Repo.update(changeset) do
      {:ok, post_and_talk} ->
        conn
        |> put_flash(:info, "Post and talk updated successfully.")
        |> redirect(to: post_and_talk_path(conn, :show, post_and_talk))
      {:error, changeset} ->
        render(conn, "edit.html", post_and_talk: post_and_talk, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post_and_talk = Repo.get!(PostAndTalk, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post_and_talk)

    conn
    |> put_flash(:info, "Post and talk deleted successfully.")
    |> redirect(to: post_and_talk_path(conn, :index))
  end
end
