defmodule Lyn.UserController do
  use Lyn.Web, :controller

  alias Lyn.Repo
  alias Lyn.User
  alias Lyn.Authorization

  def new(conn, params, current_user, _claims) do
    render conn, "new.html", current_user: current_user
  end
end
