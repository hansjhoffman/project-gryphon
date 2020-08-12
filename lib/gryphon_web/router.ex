defmodule GryphonWeb.Router do
  use GryphonWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :feed do
    plug :accepts, ["xml"]
  end

  scope "/", GryphonWeb do
    pipe_through :browser

    get "/", BlogController, :index
    get "/about", AboutController, :index
    get "/:slug", BlogController, :show, as: :post
    # get "/sitemap.xml", SitemapController, :index
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: GryphonWeb.Telemetry
    end
  end
end
