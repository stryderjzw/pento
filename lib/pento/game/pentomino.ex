defmodule Pento.Game.Pentomino do
  alias Pento.Game.{Point, Shape}

  @names [:i, :l, :y, :n, :p, :w, :u, :v, :s, :f, :x, :t]
  @default_location {8, 8}

  defstruct name: :i,
            rotation: 0,
            reflected: false,
            location: @default_location

  def new(options \\ []) do
    opts = Keyword.merge([rotation: 0, reflected: false, location: @default_location], options)

    name = Keyword.get(opts, :name)
    rotation = Keyword.get(opts, :rotation)
    reflected = Keyword.get(opts, :reflected)
    location = Keyword.get(opts, :location)

    if name in @names do
      __struct__(name: name, rotation: rotation, reflected: reflected, location: location)
    else
      raise ArgumentError, "Invalid name: #{inspect(name)}. Valid names are: #{inspect(@names)}"
    end
  end

  def rotate(%{rotation: degrees} = p) do
    %{p | rotation: rem(degrees + 90, 360)}
  end

  def flip(%{reflected: reflection} = p) do
    %{p | reflected: not reflection}
  end

  def up(p) do
    %{p | location: Point.move(p.location, {0, -1})}
  end

  def down(p) do
    %{p | location: Point.move(p.location, {0, 1})}
  end

  def left(p) do
    %{p | location: Point.move(p.location, {-1, 0})}
  end

  def right(p) do
    %{p | location: Point.move(p.location, {1, 0})}
  end

  def to_shape(pento) do
    Shape.new(pento.name, pento.rotation, pento.reflected, pento.location)
  end
end
