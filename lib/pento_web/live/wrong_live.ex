defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    random_number = Enum.random(1..10)

    {:ok,
     assign(socket, game_ended: false, score: 0, answer: random_number, message: "Make a guess:")}
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">
      Your score: <%= @score %>
    </h1>
    <h2>
      <%= @message %>

      <%= if @game_ended do %>
        <.link
          navigate={~p"/guess"}
          class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
        >
          Restart Game
        </.link>
      <% end %>
    </h2>
    <br />
    <h2>
      <%= for n <- 1..10 do %>
        <.link
          class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
          phx-click="guess"
          phx-value-number={n}
        >
          <%= n %>
        </.link>
      <% end %>
    </h2>
    """
  end

  def handle_event("guess", _params, %{assigns: %{game_ended: true}} = socket) do
    {:noreply, socket}
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    case String.to_integer(guess) == socket.assigns.answer do
      true ->
        message = "Your guess: #{guess}. Correct! "
        score = socket.assigns.score + 1
        {:noreply, assign(socket, message: message, score: score, game_ended: true)}

      false ->
        message = "Your guess: #{guess}. Wrong. Guess again. "
        score = socket.assigns.score - 1
        {:noreply, assign(socket, message: message, score: score)}
    end
  end
end
