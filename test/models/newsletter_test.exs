defmodule ElixirResources.NewsletterTest do
  use ElixirResources.ModelCase

  alias ElixirResources.Newsletter

  @valid_attrs %{cover: "some content", description: "some content", title: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Newsletter.changeset(%Newsletter{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Newsletter.changeset(%Newsletter{}, @invalid_attrs)
    refute changeset.valid?
  end
end
