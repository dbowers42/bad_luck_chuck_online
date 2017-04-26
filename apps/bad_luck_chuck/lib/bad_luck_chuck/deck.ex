defmodule BadLuckChuck.Deck do
  @moduledoc """
  """
  alias BadLuckChuck.Card
  alias BadLuckChuck.Sequencer

  import BadLuckChuck.Pile, only: [same_rank?: 1, same_suit?: 1]

  def minimum_cards?(cards) when is_list(cards) do
     Enum.count(cards) >= 3
  end

  def book?(cards) do
    minimum_cards?(cards) && same_rank?(cards)
  end

  def run?(cards) do
    cond do
      !minimum_cards?(cards) -> false       # A run must have at least 3 cards
      !same_suit?(cards) -> false           # The cards must have the same suit
      Sequencer.sequential?(cards) -> true  # Card ranks must be sequential
      true -> false                         # These cards are not a run
    end
  end
end
