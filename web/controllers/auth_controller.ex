defmodule ElixirResources.AuthController do
  use ElixirResources.Web, :controller

  alias ElixirResources.Query


  def index(conn, _params) do
    render conn, "index.html"
  end

  def request(conn, %{"provider" => provider}) do
    redirect conn, external: authorize_url!(provider)
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(conn, %{"provider" => provider, "code" => code}) do
    client = get_token!(provider, code)
    user = get_user!(provider, client)

    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/")
  end

  defp authorize_url!("google"), do: Google.authorize_url!(scope: "email profile")
  
  defp authorize_url!(_), do: raise "No matching provider available"
  

  defp get_token!("google", code), do: Google.get_token!(code: code)

  defp get_token!(_, _), do: raise "No matching provider available"
 

  defp get_user!("google", client) do
    user_url = "https://www.googleapis.com/plus/v1/people/me/openIdConnect"
    {:ok, %{body: user}} = OAuth2.Client.get(client, user_url)

    user_present = Query.check_email(user["email"])

    if user_present do
      user_present
    else 
      Query.insert_into_database(user)
    end
    
    
  end

end