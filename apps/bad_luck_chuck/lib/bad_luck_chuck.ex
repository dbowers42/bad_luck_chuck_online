defmodule BadLuckChuck do
  @moduledoc """
  """
  alias BadLuckChuck.Pile
  alias BadLuckChuck.Deck
  def start(_type, _args) do
    cards = [:c1, :h4, :h3, :c2]

    Deck.same_rank

    cards
    |> Pile.points()
    |> IO.inspect

    {:ok, self()}
  end
end
