defmodule GryphonWeb.TagController do
  use GryphonWeb, :controller

  alias Gryphon.Blog

  def index(conn, _params) do
    tags = Blog.all_tags()

    render(conn, "index.html", tags: tags)
  end

  def show(conn, %{"id" => tag}) do
    posts = Blog.get_posts_by_tag!(tag)

    render(conn, "show.html", posts: posts, tag: tag)
  end
end
