defmodule Lyn.Router do
  use Lyn.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Lyn do
    pipe_through :browser # Use the default browser stack

    # Static
    get "/", PageController, :index

    # Authentication
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    get "/admin", AdminController, :dashboard

    get "/admin/sql", Admin.SqlController, :index

    get "/admin/maintenance", Admin.MaintenanceController, :index
    get "/admin/maintenance/checkdb", Admin.MaintenanceController, :checkdb
    get "/admin/maintenance/reset_cache", Admin.MaintenanceController, :reset_cache
    get "/admin/maintenance/dbdump", Admin.MaintenanceController, :dbdump
    get "/admin/maintenance/dbload", Admin.MaintenanceController, :dbload
    get "/admin/maintenance/system_limits", Admin.MaintenanceController, :system_limits

    get "/admin/:resource/", AdminController, :index
    get "/admin/:resource/new", AdminController, :new
    get "/admin/:resource/:id/edit", AdminController, :edit
    post "/admin/:resource/", AdminController, :create
    patch "/admin/:resource/:id", AdminController, :update
    put "/admin/:resource/:id", AdminController, :update
    delete "/admin/:resource/:id", AdminController, :delete
    post "/admin/:resource/batch_action", AdminController, :batch_action
  end

  scope "/auth", Lyn do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Lyn do
  #   pipe_through :api
  # end
end
