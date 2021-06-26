defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "wher a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "lms2@icomp.ufam.edu.br", name: "Linnik", password: "senha12345"}

      {:ok, %User{id: user_id}} = Create.call(params)
      query = """
        query{
          getUser(id: "#{user_id}"){
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "lms2@icomp.ufam.edu.br",
            "name" => "Linnik"
          }
        }
      }

      assert response == expected_response
    end
  end

  describe "users mutations" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation{
          createUser(input: {
            name: "Linnik",
            email: "lms2@icomp.ufam.edu.br",
            password: "senha12345"
          }){
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Linnik"}}} = response
    end
  end
end
