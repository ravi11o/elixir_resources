defmodule ElixirResources.JobController do
  use ElixirResources.Web, :controller

  alias ElixirResources.Job
  alias ElixirResources.Query

  def index(conn, _params) do
    jobs = Repo.all(Job)
    render(conn, "index.html", jobs: jobs)
  end

  def new(conn, _params) do
    changeset = Job.changeset(%Job{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"job" => job_params}) do
    slug = 
      job_params
      |> Map.get("title")
      |> Slugger.slugify_downcase
    job_params = 
      if Query.check_slug(Job, slug) do
        Map.put_new(job_params, "slug", slug <> "-" <> UUID.uuid1())
      else
        Map.put_new(job_params, "slug", slug)
      end

    changeset = Job.changeset(%Job{}, job_params)

    case Repo.insert(changeset) do
      {:ok, _job} ->
        conn
        |> put_flash(:info, "Job created successfully.")
        |> redirect(to: job_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    job = Repo.get!(Job, id)
    render(conn, "show.html", job: job)
  end

  def edit(conn, %{"id" => id}) do
    job = Repo.get!(Job, id)
    changeset = Job.changeset(job)
    render(conn, "edit.html", job: job, changeset: changeset)
  end

  def update(conn, %{"id" => id, "job" => job_params}) do
    job = Repo.get!(Job, id)
    changeset = Job.changeset(job, job_params)

    case Repo.update(changeset) do
      {:ok, job} ->
        conn
        |> put_flash(:info, "Job updated successfully.")
        |> redirect(to: job_path(conn, :show, job))
      {:error, changeset} ->
        render(conn, "edit.html", job: job, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    job = Repo.get!(Job, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(job)

    conn
    |> put_flash(:info, "Job deleted successfully.")
    |> redirect(to: job_path(conn, :index))
  end
end
