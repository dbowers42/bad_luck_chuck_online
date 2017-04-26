defmodule BadLuckChuck.Card do
  def rank(card) when is_atom(card) do
    card
    |> Atom.to_string()
    |> String.graphemes()
    |> Enum.split(1)
    |> elem(1)
    |> Enum.join()
    |> String.to_integer()
  end

  def suit(card) when is_atom(card) do
    code = card
    |> Atom.to_string()
    |> String.graphemes()
    |> Enum.at(0)

    case code do
      "c" -> "Clubs"
      "d" -> "Diamonds"
      "h" -> "Hearts"
      "s" -> "Spades"
     end
  end

  def display_name(card) when is_atom(card) do
    rank_name = %{
      1 => "Ace",
      11 => "Jack",
      12 => "Queen",
      13 => "King",
      14 => "Ace"
    } |> Map.get(rank(card), Integer.to_string(rank(card)))

    "#{rank_name} of #{suit(card)}"
  end

  def points(card) when is_atom(card) do
    r = rank(card)

    cond do
      r in [1, 14] -> 15
      r > 9 -> 10
      true -> 5
    end
  end
end
