defmodule ElixirResources.LearningControllerTest do
  use ElixirResources.ConnCase

  alias ElixirResources.Learning
  @valid_attrs %{author: "some content", cover: "some content", description: "some content", price: "some content", resource: "some content", t: "some content", title: "some content", website: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, learning_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing learnings"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, learning_path(conn, :new)
    assert html_response(conn, 200) =~ "New learning"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, learning_path(conn, :create), learning: @valid_attrs
    assert redirected_to(conn) == learning_path(conn, :index)
    assert Repo.get_by(Learning, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, learning_path(conn, :create), learning: @invalid_attrs
    assert html_response(conn, 200) =~ "New learning"
  end

  test "shows chosen resource", %{conn: conn} do
    learning = Repo.insert! %Learning{}
    conn = get conn, learning_path(conn, :show, learning)
    assert html_response(conn, 200) =~ "Show learning"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, learning_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    learning = Repo.insert! %Learning{}
    conn = get conn, learning_path(conn, :edit, learning)
    assert html_response(conn, 200) =~ "Edit learning"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    learning = Repo.insert! %Learning{}
    conn = put conn, learning_path(conn, :update, learning), learning: @valid_attrs
    assert redirected_to(conn) == learning_path(conn, :show, learning)
    assert Repo.get_by(Learning, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    learning = Repo.insert! %Learning{}
    conn = put conn, learning_path(conn, :update, learning), learning: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit learning"
  end

  test "deletes chosen resource", %{conn: conn} do
    learning = Repo.insert! %Learning{}
    conn = delete conn, learning_path(conn, :delete, learning)
    assert redirected_to(conn) == learning_path(conn, :index)
    refute Repo.get(Learning, learning.id)
  end
end
