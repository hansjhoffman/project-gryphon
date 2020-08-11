import Config

config :gryphon, GryphonWeb.Endpoint,
  http: [:inet6, port: System.get_env("PORT", "4000") |> String.to_integer()],
  url: [host: nil, port: 443]
