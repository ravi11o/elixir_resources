defmodule ElixirResources.PostAndTalkControllerTest do
  use ElixirResources.ConnCase

  alias ElixirResources.PostAndTalk
  @valid_attrs %{cover: "some content", price: "some content", resource: "some content", tags: [], title: "some content", website: "some content", writer: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, post_and_talk_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing postandtalks"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, post_and_talk_path(conn, :new)
    assert html_response(conn, 200) =~ "New post and talk"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, post_and_talk_path(conn, :create), post_and_talk: @valid_attrs
    assert redirected_to(conn) == post_and_talk_path(conn, :index)
    assert Repo.get_by(PostAndTalk, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, post_and_talk_path(conn, :create), post_and_talk: @invalid_attrs
    assert html_response(conn, 200) =~ "New post and talk"
  end

  test "shows chosen resource", %{conn: conn} do
    post_and_talk = Repo.insert! %PostAndTalk{}
    conn = get conn, post_and_talk_path(conn, :show, post_and_talk)
    assert html_response(conn, 200) =~ "Show post and talk"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, post_and_talk_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    post_and_talk = Repo.insert! %PostAndTalk{}
    conn = get conn, post_and_talk_path(conn, :edit, post_and_talk)
    assert html_response(conn, 200) =~ "Edit post and talk"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    post_and_talk = Repo.insert! %PostAndTalk{}
    conn = put conn, post_and_talk_path(conn, :update, post_and_talk), post_and_talk: @valid_attrs
    assert redirected_to(conn) == post_and_talk_path(conn, :show, post_and_talk)
    assert Repo.get_by(PostAndTalk, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    post_and_talk = Repo.insert! %PostAndTalk{}
    conn = put conn, post_and_talk_path(conn, :update, post_and_talk), post_and_talk: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit post and talk"
  end

  test "deletes chosen resource", %{conn: conn} do
    post_and_talk = Repo.insert! %PostAndTalk{}
    conn = delete conn, post_and_talk_path(conn, :delete, post_and_talk)
    assert redirected_to(conn) == post_and_talk_path(conn, :index)
    refute Repo.get(PostAndTalk, post_and_talk.id)
  end
end
