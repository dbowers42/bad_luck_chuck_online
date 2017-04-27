defmodule BadLuckChuck do
  @moduledoc """
  """
  alias BadLuckChuck.Pile
  alias BadLuckChuck.Deck
  def start(_type, _args) do
    cards = [:c1, :c2, :h3]

    Deck.run?(cards) |> IO.inspect
    {:ok, self()}
  end
end
