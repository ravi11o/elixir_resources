defmodule ElixirResources.PostAndTalkTest do
  use ElixirResources.ModelCase

  alias ElixirResources.PostAndTalk

  @valid_attrs %{cover: "some content", price: "some content", resource: "some content", tags: [], title: "some content", website: "some content", writer: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostAndTalk.changeset(%PostAndTalk{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostAndTalk.changeset(%PostAndTalk{}, @invalid_attrs)
    refute changeset.valid?
  end
end
