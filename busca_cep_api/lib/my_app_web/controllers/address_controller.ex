defmodule MyAppWeb.AddressController do
  use MyAppWeb, :controller

  alias MyApp.Address
  alias MyAppWeb.ErrorView

  def index(conn, params) do
    with {:ok, cep} <- Address.validate_cep(params),
         {:ok, address} <- Address.get_address_by_cep(cep) do
      conn
      |> put_status(200)
      |> render("show_address.json", %{address: address})
    else
      {:error, reason} -> handle_error(conn, reason)
    end
  end

  defp handle_error(conn, :not_found) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("404.json", result: {:error, :cep_not_found})
  end

  defp handle_error(conn, :invalid_cep) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("400.json", result: {:error, :invalid_cep})
  end
end
