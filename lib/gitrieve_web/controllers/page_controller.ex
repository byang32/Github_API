defmodule GitrieveWeb.PageController do
  use GitrieveWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
