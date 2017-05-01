defmodule ElixirResources.CommunityTest do
  use ElixirResources.ModelCase

  alias ElixirResources.Community

  @valid_attrs %{cover: "some content", description: "some content", social_type: "some content", title: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Community.changeset(%Community{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Community.changeset(%Community{}, @invalid_attrs)
    refute changeset.valid?
  end
end
