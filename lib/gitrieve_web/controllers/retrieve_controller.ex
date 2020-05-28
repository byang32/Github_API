defmodule GitrieveWeb.RetrieveController do
    use GitrieveWeb, :controller

    alias Gitrieve.Retrieve

    def new(conn, params) do
        changeset = Retrieve.changeset(%Retrieve{}, %{})
        
        IO.puts "++++++++++++++++"
        IO.inspect(conn)
        IO.puts "++++++++++++++++"
        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"retrieve" => retrieve}) do
        
    end
end