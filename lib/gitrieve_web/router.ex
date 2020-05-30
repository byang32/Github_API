defmodule GitrieveWeb.Router do
  use GitrieveWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GitrieveWeb do
    pipe_through :browser

    get "/", RetrieveController, :index
    get "/retrieve/new", RetrieveController, :new
    post "/retrieve", RetrieveController, :create
  end

  scope "/github", GitrieveWeb do
    pipe_through :browser 

    get "/github/search", GithubController, :search
  end
  # Other scopes may use custom stacks.
  # scope "/api", GitrieveWeb do
  #   pipe_through :api
  # end
end
