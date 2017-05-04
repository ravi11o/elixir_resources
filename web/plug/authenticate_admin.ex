defmodule ElixirResources.AuthenticateAdmin do

  import Plug.Conn
  import Phoenix.Controller
  
  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = conn.assigns.current_user
    
    authenticate_user(conn, current_user)

    if current_user do
      is_admin = current_user.is_admin
      
      authenticate_admin(conn, is_admin)
    end
    
  end

  defp authenticate_user(conn, nil) do
    conn
    |> redirect(to: "/")
    |> halt
  end

  defp authenticate_user(conn, user) do
    conn
  end

  defp authenticate_admin(conn, false) do
    conn 
    |> redirect(to: "/") 
    |> halt
  end

  defp authenticate_admin(conn, true) do
    conn
  end
end