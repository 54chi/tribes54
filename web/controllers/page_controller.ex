defmodule Tribes54.PageController do
  use Tribes54.Web, :controller

  def index(conn, _params) do
    conn
    |> assign(:current_user, get_session(conn, :current_user))
    |> render("index.html")
  end
end
