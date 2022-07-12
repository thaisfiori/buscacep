defmodule MyApp.Address.CreateTest do
  use MyApp.DataCase

  import Mox

  alias MyApp.Address
  alias MyApp.Address.Create
  alias MyApp.ViaCep.ClientMock

  describe "execute/1" do
    test "succeed when cep is valid and isn't in database" do
      cep = "06460010"

      expect(ClientMock, :get_cep_info, fn "06460010" ->
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

      response = Create.execute(cep)

      # verifico se a resposta é a esperada
      assert {:ok, %Address{cep: ^cep}} = response
    end

    test "changeset error when cep is valid and already exists in database" do
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

      Create.execute(cep)
      response = Create.execute(cep)

      # verifico se a resposta é um erro de unique_constraint no changeset
      assert {:error, %Ecto.Changeset{errors: [cep: {"has already been taken", _}]}} = response
    end

    test "error when there are invalid params" do
      cep = "1234"

      assert {:error, :invalid_cep} = Create.execute(cep)
    end
  end
end
