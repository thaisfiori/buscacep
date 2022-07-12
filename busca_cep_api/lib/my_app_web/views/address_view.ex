defmodule MyAppWeb.AddressView do
  @doc """
  View for address
  """
  use MyAppWeb, :view

  def render("show_address.json", %{address: address}) do
    %{
      cep: address.cep,
      logradouro: address.logradouro,
      localidade: address.localidade,
      uf: address.uf,
      bairro: address.bairro
    }
  end
end
