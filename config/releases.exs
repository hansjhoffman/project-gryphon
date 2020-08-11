import Config

app_name =
  System.get_env("APP_NAME") ||
    raise """
    environment variable APP_NAME is missing.
    """

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :gryphon, GryphonWeb.Endpoint,
  http: [:inet6, port: System.get_env("PORT", "4000") |> String.to_integer()],
  url: [host: app_name <> ".gigalixirapp.com", port: 443],
  secret_key_base: secret_key_base