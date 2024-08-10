defmodule MetaprogramingWeb.ErrorJSONTest do
  use MetaprogramingWeb.ConnCase, async: true

  test "renders 404" do
    assert MetaprogramingWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert MetaprogramingWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
