defmodule ElixirResources.FollowTest do
  use ElixirResources.ModelCase

  alias ElixirResources.Follow

  @valid_attrs %{cover: "some content", name: "some content", resource: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Follow.changeset(%Follow{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Follow.changeset(%Follow{}, @invalid_attrs)
    refute changeset.valid?
  end
end
