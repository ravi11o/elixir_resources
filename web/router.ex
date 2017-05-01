defmodule ElixirResources.Router do
  use ElixirResources.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirResources do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/learnings", LearningController
    resources "/postandtalks", PostAndTalkController
    resources "/frameworks", FrameworkController
    resources "/follow", FollowController
    resources "/communities", CommunityController
    resources "/jobs", JobController
    resources "/companies", CompanyController


  end

  scope "/", as: :admin do
    pipe_through :browser

    get "/admin", ElixirResources.AuthController, :index
    get "/auth/:provider", ElixirResources.AuthController, :request
    get "/auth/:provider/callback", ElixirResources.AuthController, :callback
    delete "/auth/logout", ElixirResources.AuthController, :delete
  end


  defp assign_current_user(conn, _) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end


  # Other scopes may use custom stacks.
  # scope "/api", ElixirResources do
  #   pipe_through :api
  # end
end
