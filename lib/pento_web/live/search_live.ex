defmodule PentoWeb.SearchLive do
  use PentoWeb, :live_view

  alias Pento.Search
  alias Pento.Search.SearchBySKU

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:query, %SearchBySKU{})
     |> clear_form()}
  end

  def clear_form(socket) do
    form =
      socket.assigns.query
      |> Search.change_query_by_sku()
      |> to_form()

    assign(socket, :form, form)
  end

  def render(assigns) do
    ~H"""
    <.header>
      Search by SKU
      <:subtitle>SKU must be at least 7 digits</:subtitle>
    </.header>

    <.simple_form for={@form} phx-change="validate" phx-submit="save">
      <.input field={@form[:sku]} label="SKU" phx-debounce="blur" />
      <:actions>
        <.button>Search</.button>
      </:actions>
    </.simple_form>
    """
  end

  def handle_event("validate", %{"search_by_sku" => params}, %{assigns: %{query: query}} = socket) do
    changeset =
      query
      |> Search.change_query_by_sku(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  def handle_event("save", %{"search_by_sku" => _params}, %{assigns: %{query: _query}} = socket) do
    socket = put_flash(socket, :error, "Maybe later...")

    {:noreply, socket}
  end
end
