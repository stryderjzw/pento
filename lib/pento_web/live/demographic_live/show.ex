defmodule PentoWeb.DemographicLive.Show do
  use Phoenix.Component
  use Phoenix.HTML

  alias Pento.Survey.Demographic
  alias PentoWeb.CoreComponents

  attr :demographic, Demographic, required: true

  def details(assigns) do
    ~H"""
    <div>
      <h2 class="font-medium text-2xl">Demographics <%= raw("&#x2713;") %></h2>

      <CoreComponents.table rows={[@demographic]} id={to_string(@demographic.id)}>
        <:col :let={demographic} label="Gender">
          <%= demographic.gender %>
        </:col>
        <:col :let={demographic} label="Year of Birth">
          <%= demographic.year_of_birth %>
        </:col>
        <:action>Build</:action>
        <:action>Test</:action>
        <:action>Run</:action>
      </CoreComponents.table>
    </div>
    """
  end
end
