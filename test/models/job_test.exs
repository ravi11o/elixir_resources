defmodule ElixirResources.JobTest do
  use ElixirResources.ModelCase

  alias ElixirResources.Job

  @valid_attrs %{cover: "some content", remote: true, source: "some content", title: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Job.changeset(%Job{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Job.changeset(%Job{}, @invalid_attrs)
    refute changeset.valid?
  end
end
