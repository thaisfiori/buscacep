defmodule MyApp.Address.GetAddressByCep do
  @doc """
  Get address by cep.
  This module fetches for cep on db or call for create one, if cep doesn't exists yet.
  """
  alias MyApp.{Address, Repo}
  alias MyApp.Address.Create

  @spec execute(String.t()) :: {:ok, Ecto.Schema.t()} | {:error, atom()}
  def execute(cep) do
    case Repo.get_by(Address, cep: cep) do
      nil -> Create.execute(cep)
      %Address{} = address -> {:ok, address}
    end
  end
end
