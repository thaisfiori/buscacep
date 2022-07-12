defmodule MyAppWeb.AddressControllerTest do
  use MyAppWeb.ConnCase

  import Mox

  alias MyApp.ViaCep.ClientMock

  describe "GET /api/:cep" do
    test "succeed  with valid params", %{conn: conn} do
      cep = "06460010"

      expect(ClientMock, :get_cep_info, 2, fn "06460010" ->
        {:ok,
         %{
           cep: "06460-010",
           logradouro: "Avenida Aruanã",
           complemento: "",
           bairro: "Tamboré",
           localidade: "Barueri",
           uf: "SP",
           ibge: "3505708",
           gia: "2069",
           ddd: "11",
           siafi: "6213"
         }}
      end)

      assert %{
               "cep" => ^cep,
               "logradouro" => "Avenida Aruanã",
               "localidade" => "Barueri",
               "uf" => "SP",
               "bairro" => "Tamboré"
             } =
               conn
               |> get("/api/" <> cep)
               |> json_response(200)
    end

    test "404 when cep is valid but doesn't exists", %{conn: conn} do
      cep = "00000000"

      expect(ClientMock, :get_cep_info, fn ^cep -> {:error, :not_found} end)

      conn
      |> get("/api/" <> cep)
      |> json_response(404)
    end

    test "400 when cep is invalid", %{conn: conn} do
      cep = "cep"

      expect(ClientMock, :get_cep_info, fn ^cep -> {:error, :invalid_cep} end)

      conn
      |> get("/api/" <> cep)
      |> json_response(400)
    end
  end
end
