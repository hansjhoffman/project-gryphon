defmodule GryphonWeb.BlogController do
  use GryphonWeb, :controller

  alias Gryphon.Blog

  def index(conn, _params) do
    posts = Blog.all_posts()

    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => slug}) do
    perma_id =
      slug
      |> String.split("-")
      |> hd

    post = perma_id |> Blog.get_post()

    render(conn, "show.html", post: post)
  end
end
