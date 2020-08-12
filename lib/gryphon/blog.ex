defmodule Gryphon.Blog do
  @moduledoc false

  alias Gryphon.Blog.Post

  for app <- [:earmark, :makeup_elixir] do
    Application.ensure_all_started(app)
  end

  defmodule NotFoundError do
    defexception [:message, plug_status: 404]
  end

  posts_path =
    "posts/*.md"
    |> Path.wildcard()
    |> Enum.sort()

  posts =
    for post_path <- posts_path do
      @external_resource Path.relative_to_cwd(post_path)
      Post.parse!(post_path)
    end

  @posts Enum.sort_by(posts, & &1.date, {:desc, Date})

  def all_posts, do: @posts

  def get_post(slug), do: Enum.filter(@posts, &(&1.id == slug)) |> List.first()
end
