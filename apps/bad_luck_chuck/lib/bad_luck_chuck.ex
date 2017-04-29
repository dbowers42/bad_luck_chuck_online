defmodule BadLuckChuck do
  alias BadLuckChuck.Pile

  def start(_type, _args) do

    cards = [:c3, :c1, :h1, :c2, :h3, :h2]

    Pile.sort(cards, :suit) |> IO.inspect
    {:ok, self()}
  end
end
