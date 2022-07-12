defmodule MyApp.ViaCep.Client do
  use Tesla
  alias Tesla.Env

  @url_base "https://viacep.com.br/ws/"

  # codifica de decodifica os parâmetros de envio/resposta para json
  plug(Tesla.Middleware.JSON)

  def get_cep_info(url \\ @url_base, cep) do
    (url <> cep <> "/json")
    |> get()
    |> handle_response()
  end

  # caso não encontre o cep
  defp handle_response({:ok, %Env{status: 200, body: %{"erro" => "true"}}}) do
    {:error, :not_found}
  end

  # caso de sucesso
  defp handle_response({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  # caso o cep tenha um formato inválido (não deveria acontecer)
  defp handle_response({:ok, %Env{status: 400, body: _body}}) do
    {:error, :invalid_cep}
  end

  # erro desconhecido
  defp handle_response({:error, reason}) do
    {:error, reason}
  end
end
