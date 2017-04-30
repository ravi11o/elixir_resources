defmodule ElixirResources.LearningTest do
  use ElixirResources.ModelCase

  alias ElixirResources.Learning

  @valid_attrs %{author: "some content", cover: "some content", description: "some content", price: "some content", resource: "some content", t: "some content", title: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Learning.changeset(%Learning{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Learning.changeset(%Learning{}, @invalid_attrs)
    refute changeset.valid?
  end
end
