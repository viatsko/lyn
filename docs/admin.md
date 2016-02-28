# Admin Panel
In order to make model CRUD for admin panel, you must add `admin_fields` to the
model. Example below:

```elixir
def admin_fields do
  [
    id: %{
      label: "id",
      type: :integer
    },
    outer_text: %{
      label: "outer_text",
      type: :outer_text,
      model: Lyn.ObjectText
    },
    site_id: %{
      label: "site_id",
      type: :integer
    },
    parent_id: %{
      label: "parent_id",
      type: :integer
    },
    is_published: %{
      label: "is_published",
      type: :boolean
    },
    is_show_on_site_map: %{
      label: "is_show_on_site_map",
      type: :boolean
    },
    is_show_in_menu: %{
      label: "is_show_in_menu",
      type: :boolean
    },
    sort_order: %{
      label: "sort_order",
      type: :integer
    },
    path: %{
      label: "path",
      type: :string
    },
    url: %{
      label: "url",
      type: :string
    },
    full_path: %{
      label: "full_path",
      type: :string
    }
  ]
end
```

Afterwards, you need to add necessary stuff to admin_controller.ex:

```elixir
alias Lyn.Domain
alias Lyn.Language
alias Lyn.Object # add this
alias Lyn.ObjectType
alias Lyn.Site
alias Lyn.User

def models, do: %{
  "domains" => Domain,
  "languages" => Language,
  "objects" => Object, # add this
  "object_types" => ObjectType,
  "sites" => Site,
  "users" => User
}
```

After you finished this, your new admin CRUD will be available using `/admin/objects`
url.

This might change in future versions as Lyn is under heavy development.
