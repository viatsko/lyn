defmodule Lyn.Admin.DomainController do
  use Lyn.Web, :controller

  alias Lyn.Domain

  plug :scrub_params, "domain" when action in [:create, :update]

  def index(conn, _params) do
    domains = Repo.all(Domain)
    render(conn, "index.html", domains: domains)
  end

  def new(conn, _params) do
    changeset = Domain.changeset(%Domain{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"domain" => domain_params}) do
    changeset = Domain.changeset(%Domain{}, domain_params)

    case Repo.insert(changeset) do
      {:ok, _domain} ->
        conn
        |> put_flash(:info, "Domain created successfully.")
        |> redirect(to: domain_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    domain = Repo.get!(Domain, id)
    render(conn, "show.html", domain: domain)
  end

  def edit(conn, %{"id" => id}) do
    domain = Repo.get!(Domain, id)
    changeset = Domain.changeset(domain)
    render(conn, "edit.html", domain: domain, changeset: changeset)
  end

  def update(conn, %{"id" => id, "domain" => domain_params}) do
    domain = Repo.get!(Domain, id)
    changeset = Domain.changeset(domain, domain_params)

    case Repo.update(changeset) do
      {:ok, domain} ->
        conn
        |> put_flash(:info, "Domain updated successfully.")
        |> redirect(to: domain_path(conn, :show, domain))
      {:error, changeset} ->
        render(conn, "edit.html", domain: domain, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    domain = Repo.get!(Domain, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(domain)

    conn
    |> put_flash(:info, "Domain deleted successfully.")
    |> redirect(to: domain_path(conn, :index))
  end
end
