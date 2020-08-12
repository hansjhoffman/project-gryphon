defmodule GryphonWeb.SitemapController do
  use GryphonWeb, :controller

  alias Gryphon.Blog

  def index(conn, _params) do
    posts = Blog.all_posts()

    conn
    |> put_resp_content_type("text/xml")
    |> render("index.xml", posts: posts)
  end
end
