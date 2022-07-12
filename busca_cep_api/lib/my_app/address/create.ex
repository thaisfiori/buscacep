defmodule MyApp.Address.Create do
  alias MyApp.{Address, Repo}

  @type address_params :: %{
          cep: String.t(),
          logradouro: String.t(),
          complemento: String.t(),
          bairro: String.t(),
          uf: String.t(),
          ibge: String.t(),
          gia: String.t(),
          ddd: String.t(),
          siafi: String.t()
        }
  def execute(param) do
    with {:ok, cep} <- Address.validate_cep(%{"cep" => param}),
         {:ok, params} <- client().get_cep_info(cep),
         changeset <- Address.changeset(params),
         {:ok, %Address{}} = address <- Repo.insert(changeset) do
      address
    end
  end

  defp client() do
    :my_app
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:via_cep_adapter)
  end
end
