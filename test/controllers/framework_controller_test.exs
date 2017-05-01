defmodule ElixirResources.FrameworkControllerTest do
  use ElixirResources.ConnCase

  alias ElixirResources.Framework
  @valid_attrs %{cover: "some content", description: "some content", title: "some content", website: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, framework_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing frameworks"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, framework_path(conn, :new)
    assert html_response(conn, 200) =~ "New framework"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, framework_path(conn, :create), framework: @valid_attrs
    assert redirected_to(conn) == framework_path(conn, :index)
    assert Repo.get_by(Framework, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, framework_path(conn, :create), framework: @invalid_attrs
    assert html_response(conn, 200) =~ "New framework"
  end

  test "shows chosen resource", %{conn: conn} do
    framework = Repo.insert! %Framework{}
    conn = get conn, framework_path(conn, :show, framework)
    assert html_response(conn, 200) =~ "Show framework"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, framework_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    framework = Repo.insert! %Framework{}
    conn = get conn, framework_path(conn, :edit, framework)
    assert html_response(conn, 200) =~ "Edit framework"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    framework = Repo.insert! %Framework{}
    conn = put conn, framework_path(conn, :update, framework), framework: @valid_attrs
    assert redirected_to(conn) == framework_path(conn, :show, framework)
    assert Repo.get_by(Framework, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    framework = Repo.insert! %Framework{}
    conn = put conn, framework_path(conn, :update, framework), framework: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit framework"
  end

  test "deletes chosen resource", %{conn: conn} do
    framework = Repo.insert! %Framework{}
    conn = delete conn, framework_path(conn, :delete, framework)
    assert redirected_to(conn) == framework_path(conn, :index)
    refute Repo.get(Framework, framework.id)
  end
end
