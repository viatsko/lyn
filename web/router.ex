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

    # Admin Routes
    get "/admin", AdminController, :index

    resources "/admin/objects", Admin.ObjectController
    resources "/admin/users", Admin.UserController

    get "/admin/:resource/", AdminController, :index
    get "/admin/:resource/new", AdminController, :new
    get "/admin/:resource/:id", AdminController, :show
    get "/admin/:resource/:id/edit", AdminController, :edit
    post "/admin/:resource/", AdminController, :create
    patch "/admin/:resource/:id", AdminController, :update
    put "/admin/:resource/:id", AdminController, :update
    delete "/admin/:resource/:id", AdminController, :destroy
    post "/admin/:resource/batch_action", AdminController, :batch_action

    resources "/admin/object_types", Admin.ObjectTypeController
    resources "/admin/languages", Admin.LanguageController
    resources "/admin/sites", Admin.SiteController
    resources "/admin/domains", Admin.DomainController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Lyn do
  #   pipe_through :api
  # end
end
