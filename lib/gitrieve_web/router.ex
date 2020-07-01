defmodule GitrieveWeb.Router do
  use GitrieveWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug GitrieveWeb.Plugs.SetUser
    # plug GitrieveWeb.Plugs.RequireAuth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GitrieveWeb do
    pipe_through :browser

    # resources "/", RetrieveController, 
    get "/", RetrieveController, :index
    get "/retrieve/new", RetrieveController, :new
    post "/retrieve", RetrieveController, :create
    get "/retrieve/:id", RetrieveController, :show
    delete "/retrieve/:id", RetrieveController, :delete
    
  end

  scope "/auth", GitrieveWeb do
    pipe_through :browser

    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end
  # Other scopes may use custom stacks.
  # scope "/api", GitrieveWeb do
  #   pipe_through :api
  # end
end
