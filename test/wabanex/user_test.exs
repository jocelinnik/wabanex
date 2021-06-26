defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Linnik", email: "lms2@icomp.ufam.edu.br", password: "senha12345"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: true,
        changes: %{
          email: "lms2@icomp.ufam.edu.br",
          name: "Linnik",
          password: "senha12345"
        },
        errors: []
      } = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params = %{name: "L", email: "lms2@icomp.ufam.edu.br"}

      response = User.changeset(params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
