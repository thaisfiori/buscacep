defmodule MyApp.Export.CsvContent do
  def call(records, fields) do
    records
    |> Enum.map(fn record ->
      record
      |> Map.from_struct()
      # gives an empty map
      |> Map.take([])
      |> Map.merge(Map.take(record, fields))
      |> Map.values()
    end)
    |> CSV.encode()
    |> Enum.to_list()
    |> to_string()
  end
end
