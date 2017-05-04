defmodule ElixirResources.Router do
  use ElixirResources.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :assign_current_user
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    
    
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin_layout do
    plug :put_layout, {ElixirResources.LayoutView, :dashboard}
    plug ElixirResources.AuthenticateAdmin
  end

  scope "/", ElixirResources do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    
  end

  scope "/admin", ElixirResources do
    pipe_through [:browser, :admin_layout]

    resources "/learnings", LearningController
    resources "/postandtalks", PostAndTalkController
    resources "/frameworks", FrameworkController
    resources "/follow", FollowController
    resources "/communities", CommunityController
    resources "/jobs", JobController
    resources "/companies", CompanyController
    resources "/applications", ApplicationController
    resources "/newsletters", NewsletterController
    get "/dashboard", LearningController, :index
  end

  scope "/", as: :admin do
    pipe_through :browser

    get "/admin", ElixirResources.AuthController, :index
    get "/auth/:provider", ElixirResources.AuthController, :request
    get "/auth/:provider/callback", ElixirResources.AuthController, :callback
    delete "/auth/logout", ElixirResources.AuthController, :delete
  end


  defp assign_current_user(conn, _) do
    current_user = get_session(conn, :current_user)
    assign(conn, :current_user, current_user)
  end


  # Other scopes may use custom stacks.
  # scope "/api", ElixirResources do
  #   pipe_through :api
  # end
end
