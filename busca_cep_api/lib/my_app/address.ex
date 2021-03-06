defmodule MyApp.Address do
  use Ecto.Schema

  import Ecto.Changeset

  alias MyApp.Address.GetAddressByCep
  alias MyApp.Repo

  @required [:cep]
  @optional [:complemento, :bairro, :ibge, :gia, :ddd, :siafi, :logradouro, :uf, :localidade]

  schema "address" do
    field :cep, :string
    field :logradouro, :string
    field :localidade, :string
    field :complemento, :string
    field :bairro, :string
    field :uf, :string
    field :ibge, :string
    field :gia, :string
    field :ddd, :string
    field :siafi, :string
  end

  def changeset(address \\ %__MODULE__{}, params) do
    address
    |> cast(params, @required ++ @optional)
    |> formmat_cep()
    |> validate_length(:cep, is: 8)
    |> unique_constraint(:cep)
  end

  @doc "validate and formmat cep"
  @spec validate_cep(map()) :: {:ok, String.t()} | {:error, :invalid_atom}
  def validate_cep(%{"cep" => cep}) do
    cep = trim_cep(cep)

    case String.length(cep) do
      8 -> {:ok, cep}
      _ -> {:error, :invalid_cep}
    end
  end

  @doc "list all addresses"
  def list_all() do
    Repo.all(__MODULE__)
  end

  defp trim_cep(cep) do
    cep
    |> String.replace(".", "")
    |> String.replace("-", "")
  end

  defp formmat_cep(changeset) do
    cep =
      get_change(changeset, :cep)
      |> trim_cep

    force_change(changeset, :cep, cep)
  end

  defdelegate get_address_by_cep(param), to: GetAddressByCep, as: :execute
end
