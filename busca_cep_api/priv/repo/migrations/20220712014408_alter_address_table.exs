defmodule MyApp.Repo.Migrations.AlterAddressTable do
  use Ecto.Migration

  def change do
    alter table(:address) do
      add :localidade, :string
    end
  end
end
