defmodule MyAppWeb.ExportControllerTest do
  use MyAppWeb.ConnCase

  describe "GET /api/export" do
    test "download csv file", %{conn: conn} do
      assert %{status: 200} = get(conn, "/api/export")
    end
  end
end
