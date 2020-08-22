defmodule Gryphon.Blog.Post do
  @moduledoc """
  Core of our blog system. Includes parsing the post front-matter.
  """

  alias Gryphon.Blog.Highlighter

  @enforce_keys [:id, :slug, :title, :content, :description, :tags, :date]
  defstruct [:id, :slug, :title, :content, :description, :tags, :date]

  def parse!(filename) do
    slug = filename |> mk_slug()

    perma_id =
      slug
      |> Path.rootname()
      |> String.split("-")
      |> hd

    # Get all attributes from the contents
    contents = parse_contents(File.read!(filename))

    # Finally build the post struct
    struct!(__MODULE__, [id: perma_id, slug: slug] ++ contents)
  end

  defp mk_slug(filename) do
    filename
    |> Path.split()
    |> tl
    |> Path.rootname()
    |> String.downcase()
  end

  defp parse_contents(contents) do
    # Split contents into  ["==title==\n", "this title", "==tags==\n", "this, tags", ...]
    parts = Regex.split(~r/^==(\w+)==\n/m, contents, include_captures: true, trim: true)

    # Now chunk each attr and value into pairs and parse them
    for [attr_with_equals, value] <- Enum.chunk_every(parts, 2) do
      [_, attr, _] = String.split(attr_with_equals, "==")
      attr = String.to_atom(attr)
      {attr, parse_attr(attr, value)}
    end
  end

  defp parse_attr(:title, value) do
    value
    |> String.trim()
  end

  defp parse_attr(:description, value) do
    value
    |> String.trim()
  end

  defp parse_attr(:date, value) do
    [year, month, day] =
      value
      |> String.trim()
      |> String.split("-", parts: 3)

    Date.from_iso8601!("#{year}-#{month}-#{day}")
  end

  defp parse_attr(:tags, value) do
    value
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.sort()
  end

  defp parse_attr(:content, value) do
    value
    |> String.trim()
  end
end
