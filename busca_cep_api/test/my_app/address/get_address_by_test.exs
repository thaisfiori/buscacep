defmodule MyApp.Address.GetAddressByTest do
  use MyApp.DataCase

  import Mox

  alias MyApp.Address
  alias MyApp.Address.GetAddressByCep
  alias MyApp.Repo
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

      response = GetAddressByCep.execute(cep)

      # verifico se a resposta é um mapa com um schema
      assert {:ok, %Address{cep: ^cep}} = response
    end

    test "succeed when cep is valid and already exists on db" do
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

      GetAddressByCep.execute(cep)
      response = GetAddressByCep.execute(cep)

      # verifico se a resposta é um mapa com um schema
      assert {:ok, %Address{cep: ^cep}} = response
      # garanto que houve apenas uma inserção no banco
      assert 1 = Repo.aggregate(Address, :count)
    end
  end
end
