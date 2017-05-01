defmodule ElixirResources.CommunityController do
  use ElixirResources.Web, :controller

  alias ElixirResources.Community
  alias ElixirResources.Query

  def index(conn, _params) do
    communities = Repo.all(Community)
    render(conn, "index.html", communities: communities)
  end

  def new(conn, _params) do
    changeset = Community.changeset(%Community{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"community" => community_params}) do
     slug = 
      community_params
      |> Map.get("title")
      |> Slugger.slugify_downcase
    community_params = 
      if Query.check_slug(Community, slug) do
        Map.put_new(community_params, "slug", slug <> "-" <> UUID.uuid1())
      else
        Map.put_new(community_params, "slug", slug)
      end

    changeset = Community.changeset(%Community{}, community_params)

    case Repo.insert(changeset) do
      {:ok, _community} ->
        conn
        |> put_flash(:info, "Community created successfully.")
        |> redirect(to: community_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    community = Repo.get!(Community, id)
    render(conn, "show.html", community: community)
  end

  def edit(conn, %{"id" => id}) do
    community = Repo.get!(Community, id)
    changeset = Community.changeset(community)
    render(conn, "edit.html", community: community, changeset: changeset)
  end

  def update(conn, %{"id" => id, "community" => community_params}) do
    community = Repo.get!(Community, id)
    changeset = Community.changeset(community, community_params)

    case Repo.update(changeset) do
      {:ok, community} ->
        conn
        |> put_flash(:info, "Community updated successfully.")
        |> redirect(to: community_path(conn, :show, community))
      {:error, changeset} ->
        render(conn, "edit.html", community: community, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    community = Repo.get!(Community, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(community)

    conn
    |> put_flash(:info, "Community deleted successfully.")
    |> redirect(to: community_path(conn, :index))
  end
end
