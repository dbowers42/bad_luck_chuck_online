defmodule BadLuckChuck.Sequencer do
  @moduledoc """
  """
  alias BadLuckChuck.Card
  import BadLuckChuck.Pile, only: [sort: 2, same_suit?: 1, top: 2]

  defp sequential?([]), do: true

  defp sequential?(cards) do
    [head | tail] = sort(:rank)

    cond do
      (Enum.count(cards) == 1) -> true
      top(cards, :rank) + 1 == top(tail, :rank) && sequential?(tail) -> true
      true -> false
    end || sequential_high_ace?(cards)
  end

  defp sequential_high_ace?(cards) do
   cards
   |> Enum.map(&low_to_high/1)
   |> sort(:rank)
   |> sequential?
 end

  defp low_to_high(card) when is_atom(card) do
    cond do
      Card.rank(card) == 1 -> create_card(14, card)
      true -> card
    end
  end

  defp create_card(rank, card) do
     case Card.suit(card) do
          "Clubs" -> "c"
          "Diamonds" -> "d"
          "Hearts" -> "h"
          "Spades" -> "s"
     end <> Integer.to_string(rank)
  end
end
