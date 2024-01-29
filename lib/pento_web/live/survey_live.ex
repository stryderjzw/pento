defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view

  alias __MODULE__.Component

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
