defmodule BadLuckChuck.Pile do
  alias BadLuckChuck.Card

  def sort(cards, :rank) when is_list(cards) do
     cards
     |> Enum.sort(fn (c1, c2) -> compare_ranks(c1, c2) end)
  end

  def sort(cards, :suit) when is_list(cards) do
    cards
    |> Enum.sort(fn (c1, c2) -> compare_suits(c1, c2) end)
    |> Enum.chunk_by(fn (card) -> Card.suit(card) end)
    |> Enum.map(fn (cards) -> sort(cards, :rank) end)
    |> List.flatten()
  end

  def points(cards) when is_list(cards) do
    cards
    |> Enum.reduce(0, fn (card, acc) -> acc + Card.points(card) end)
  end

  defp compare_ranks(c1, c2) do
     Card.rank(c1) < Card.rank(c2)
  end

  defp compare_suits(c1, c2) do
    Card.suit(c1) < Card.suit(c2)
  end
end
