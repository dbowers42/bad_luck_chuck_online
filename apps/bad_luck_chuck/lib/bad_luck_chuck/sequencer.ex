defmodule BadLuckChuck.Sequencer do
  @moduledoc """
  """
  alias BadLuckChuck.Card
  import BadLuckChuck.Pile, only: [sort: 2, top: 2]

  def sequential?([]), do: true

  def sequential?(cards) do
     cards
     |> split_runs()
     |> Enum.map(fn (run) -> Task.async(fn -> continuous?(run) end) end)
     |> Task.yield_many()
     |> Enum.map(&extract_continuous_result/1)
     |> Enum.any?(&(&1))
  end

  defp extract_continuous_result(data) do
    {_, {:ok, result}} = data

    result
  end

  defp continuous?(cards) do
    length(cards) == 1 || (top(cards, :rank) + 1 == top(tl(cards), :rank) && continuous?(tl(cards)))
  end

  defp split_runs(cards) do
    [
      sort(Enum.map(cards, &low_to_high/1), :rank),
      sort(Enum.map(cards, &high_to_low/1), :rank)
    ]
  end

  defp low_to_high(card) when is_atom(card) do
    cond do
      Card.rank(card) == 1 -> create_card(14, card)
      true -> card
    end
  end

  defp high_to_low(card) when is_atom(card) do
    cond do
      Card.rank(card) == 14 -> create_card(1, card)
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
     |> String.to_atom()
  end
end
