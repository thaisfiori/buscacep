defmodule MyApp.ViaCep.Behaviour do
  @callback get_cep_info(String.t()) :: {:ok, atom()} | {:error, atom()} | {:error, String.t()}
end
