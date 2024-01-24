defmodule Pento.Search do
  alias Pento.Search.SearchBySKU

  def change_query_by_sku(%SearchBySKU{} = query, attrs \\ %{}) do
    SearchBySKU.changeset(query, attrs)
  end
end
