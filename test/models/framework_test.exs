defmodule ElixirResources.FrameworkTest do
  use ElixirResources.ModelCase

  alias ElixirResources.Framework

  @valid_attrs %{cover: "some content", description: "some content", title: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Framework.changeset(%Framework{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Framework.changeset(%Framework{}, @invalid_attrs)
    refute changeset.valid?
  end
end
