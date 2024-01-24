defmodule Pento.Search.SearchBySKU do
  import Ecto.Changeset

  defstruct [:sku]
  @types %{sku: :integer}

  def changeset(%__MODULE__{} = query, attrs) do
    {query, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required(:sku)
    |> validate_number(:sku, greater_than_or_equal_to: 1_000_000)
  end
end
