defmodule Pento.Promo do
  alias Pento.Promo.Recipient

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_promo(recipient, attrs) do
    changeset =
      recipient
      |> Recipient.changeset(attrs)

    IO.puts(inspect(changeset.data))

    if changeset.valid? == true do
      # send email to promo recipient
      {:ok, %Recipient{}}
    else
      {:error, :invalid_changeset}
    end
  end
end
