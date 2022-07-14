defmodule MyAppWeb.ExportController do
  use MyAppWeb, :controller

  alias MyApp.Address
  alias MyApp.Export.CsvContent

  def create(conn, _params) do
    fields = [
      :cep,
      :logradouro,
      :localidade,
      :complemento,
      :bairro,
      :uf,
      :ibge,
      :gia,
      :ddd,
      :siafi
    ]

    # csv_data = CsvContent.call(Address.list_all(), fields)

    task = Task.async(fn -> generate_csv(:csv, fields) end)
    res = Task.await(task)

    conn
    |> put_resp_content_type("cep/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"export.csv\"")
    |> put_root_layout(false)
    |> send_resp(200, res)
  end

  def generate_csv(:csv, fields) do
    CsvContent.call(Address.list_all(), fields)
  end
end
