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


  # A run must have at least 3 cards
  # The cards must have the same suit
  # Card ranks must be sequential
  def run?(cards) do
    minimum_cards?(cards) && same_suit?(cards) && Sequencer.sequential?(cards)
  end

  def cut(cards, divider) when is_list(cards) and is_atom(divider) do
     index = Enum.find_index(cards, &(&1 == divider)) + 1

     Enum.split_while(cards, fn card -> card != Enum.at(cards, index) end)
  end
end
