defmodule ElixirResources.NewsletterControllerTest do
  use ElixirResources.ConnCase

  alias ElixirResources.Newsletter
  @valid_attrs %{cover: "some content", description: "some content", title: "some content", website: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, newsletter_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing newsletters"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, newsletter_path(conn, :new)
    assert html_response(conn, 200) =~ "New newsletter"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, newsletter_path(conn, :create), newsletter: @valid_attrs
    assert redirected_to(conn) == newsletter_path(conn, :index)
    assert Repo.get_by(Newsletter, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, newsletter_path(conn, :create), newsletter: @invalid_attrs
    assert html_response(conn, 200) =~ "New newsletter"
  end

  test "shows chosen resource", %{conn: conn} do
    newsletter = Repo.insert! %Newsletter{}
    conn = get conn, newsletter_path(conn, :show, newsletter)
    assert html_response(conn, 200) =~ "Show newsletter"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, newsletter_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    newsletter = Repo.insert! %Newsletter{}
    conn = get conn, newsletter_path(conn, :edit, newsletter)
    assert html_response(conn, 200) =~ "Edit newsletter"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    newsletter = Repo.insert! %Newsletter{}
    conn = put conn, newsletter_path(conn, :update, newsletter), newsletter: @valid_attrs
    assert redirected_to(conn) == newsletter_path(conn, :show, newsletter)
    assert Repo.get_by(Newsletter, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    newsletter = Repo.insert! %Newsletter{}
    conn = put conn, newsletter_path(conn, :update, newsletter), newsletter: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit newsletter"
  end

  test "deletes chosen resource", %{conn: conn} do
    newsletter = Repo.insert! %Newsletter{}
    conn = delete conn, newsletter_path(conn, :delete, newsletter)
    assert redirected_to(conn) == newsletter_path(conn, :index)
    refute Repo.get(Newsletter, newsletter.id)
  end
end
