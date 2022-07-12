defmodule MyApp.Repo.Migrations.Adress do
  use Ecto.Migration

  def change do
    create table(:address) do
      add :cep, :string
      add :logradouro, :string
      add :complemento, :string
      add :bairro, :string
      add :uf, :string
      add :ibge, :string
      add :gia, :string
      add :ddd, :string
      add :siafi, :string
    end

    create unique_index(:address, [:cep])
  end
end
