defmodule Tribes54.Router do
  use Tribes54.Web, :router

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

  scope "/", Tribes54 do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/auth", Tribes54 do
    pipe_through :browser # Use the default browser stack

    get "/:provider", AuthController, :index
    get "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end



  # Other scopes may use custom stacks.
  # scope "/api", Tribes54 do
  #   pipe_through :api
  # end
end
