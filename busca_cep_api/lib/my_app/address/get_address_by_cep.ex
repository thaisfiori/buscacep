defmodule MyApp.Address.GetAddressByCep do
  alias MyApp.{Address, Repo}
  alias MyApp.Address.Create

  def execute(cep) do
    case Repo.get_by(Address, cep: cep) do
      nil -> Create.execute(cep)
      %Address{} = address -> {:ok, address}
    end
  end
end
