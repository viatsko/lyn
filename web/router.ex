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

    get "/", PageController, :index

    get "/admin", AdminController, :index

    resources "/users", UserController

    resources "/sessions", SessionController, only: [:new, :create, :delete]

    resources "/admin/languages", Admin.LanguageController

    resources "/admin/sites", Admin.SiteController

    resources "/admin/domains", Admin.DomainController

    resources "/admin/users", Admin.UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Lyn do
  #   pipe_through :api
  # end
end
