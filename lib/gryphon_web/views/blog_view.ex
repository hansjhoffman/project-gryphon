defmodule GryphonWeb.BlogView do
  use GryphonWeb, :view

  alias Gryphon.Blog.Highlighter

  def markdown(content) do
    content
    |> Earmark.as_html!()
    |> Highlighter.highlight()
    |> raw
  end
end
