defmodule GryphonWeb.BlogView do
  use GryphonWeb, :view

  alias Gryphon.Blog.Highlighter

  def as_html(content) do
    content
    |> Earmark.as_html!()
    |> Highlighter.highlight()
    |> raw
  end

  def format_date(date) do
    case Timex.format(date, "%B %d, %Y", :strftime) do
      {:ok, formatted} -> formatted
      {:error, _} -> date
    end
  end
end
