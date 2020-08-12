==title==
First Post

==date==
2020-08-11

==description==
Today we announce 1...

==tags==
elixir, react

==body==
# First post!!! 

Does this *support* markdown?

- a
- b
- c

```elixir
posts_path =
    "posts/**/*.md"
    |> Path.wildcard()
    |> Enum.sort()
```