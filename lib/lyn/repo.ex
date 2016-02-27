defmodule Lyn.Repo do
  use Ecto.Repo, otp_app: :lyn
  use Scrivener, page_size: 20
end
