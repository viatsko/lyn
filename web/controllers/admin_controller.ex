defmodule Lyn.AdminController do
  use Lyn.Web, :controller

  alias Lyn.Domain
  alias Lyn.Language
  alias Lyn.ObjectType
  alias Lyn.Site

  models = [
    domain: Domain,
    language: Language,
    object_type: ObjectType,
    site: Site
  ]

  plug :put_layout, "admin.html"

  def index(conn, _params) do
    render conn, "index.html"
  end
end
