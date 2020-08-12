defmodule GryphonWeb.BlogController do
  use GryphonWeb, :controller

  alias Gryphon.Blog

  def index(conn, _params) do
    posts = Blog.all_posts()

    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"titled_slug" => titled_slug}) do
    [perma_id | _] = titled_slug |> String.split("-")

    post = Blog.get_post(perma_id)

    render(conn, "show.html", post: post)
  end
end
