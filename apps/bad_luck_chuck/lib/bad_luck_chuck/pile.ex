defmodule BadLuckChuck.Pile do
  @moduledoc """
    The BadLuckChuck.Pile module provides common functions for manipulating
    collections of cards.
  """
  alias BadLuckChuck.Card

  @doc """
    Returns a collection of cards sorted be either rank or suit

    Sorting by rank

      iex> BadLuckChuck.Pile.sort([:c3, :c1, :h1, :c2, :h3, :h2], :suit)
      [:c1, :c2, :c3, :h1, :h2, :h3]

    Sorting by suit
      iex> BadLuckChuck.Pile.sort([:c3, :c1, :h1, :c2, :h3, :h2], :rank)
      [:c1, :h1, :c2, :h2, :c3, :h3]
  """
  def sort(cards, :rank) when is_list(cards) do
     cards
     |> Enum.sort(fn (c1, c2) -> compare_ranks(c1, c2) end)
     |> Enum.chunk_by(fn (card) -> Card.rank(card) end)
     |> Enum.map(fn (chunk) -> Enum.sort(chunk) end)
     |> List.flatten()
  end

  def sort(cards, :suit) when is_list(cards) do
    cards
    |> Enum.sort(fn (c1, c2) -> compare_suits(c1, c2) end)
    |> Enum.chunk_by(fn (card) -> Card.suit(card) end)
    |> Enum.map(fn (cards) -> sort(cards, :rank) end)
    |> List.flatten()
  end

  @doc """
    Returns the total point value of a collection of cards.
    Aces are worth 15 points. Face cards and Tens are worth 10 points.
    All other cards are worth 5 points.

      iex> BadLuckChuck.Pile.points([:c1, :c7, :c13])
      30

      iex> BadLuckChuck.Pile.points([:c4, :c5, :c6])
      15

      iex> BadLuckChuck.Pile.points([:c1, :h1, :d1])
      45

      iex> BadLuckChuck.Pile.points([:h10, :h11, :h13])
      30
  """
  def points(cards) when is_list(cards) do
    cards
    |> Enum.reduce(0, fn (card, acc) -> acc + Card.points(card) end)
  end

  @doc """
    Returns the top card from a pile

      iex> BadLuckChuck.Pile.top([:c1, :c2, :c3])
      :c1
  """
  def top(cards), do: List.first(cards)

  @doc """
    Returns the rank or suit of the top card in a pile

      iex> BadLuckChuck.Pile.top([:c1, :c2, :c3], :rank)
      1

      iex> BadLuckChuck.Pile.top([:c1, :c2, :c3], :suit)
      "Clubs"
  """
  def top(cards, :suit), do: cards |> top() |> Card.suit()
  def top(cards, :rank), do: cards |> top() |> Card.rank()

  @doc """
    Returns true if all cards in a collection of cards are the same suit

      iex> BadLuckChuck.Pile.same_suit?([:s1, :s2, :s3])
      true

      iex> BadLuckChuck.Pile.same_suit?([:s1, :d2, :s3])
      false
  """
  def same_suit?(cards) when is_list(cards) do
    suit = top(cards, :suit)
    Enum.all?(cards, fn (card) -> Card.suit(card) == suit end)
  end

  @doc """
    Returns true if all cards in a collection of cards are the same rank

      iex> BadLuckChuck.Pile.same_rank?([:s1, :d1, :s1])
      true

      iex> BadLuckChuck.Pile.same_rank?([:s1, :s2, :s1])
      false
  """
  def same_rank?(cards) when is_list(cards) do
    rank = top(cards, :rank)
    Enum.all?(cards, fn (card) -> Card.rank(card) == rank end)
  end

  defp compare_ranks(c1, c2) do
     Card.rank(c1) < Card.rank(c2)
  end

  defp compare_suits(c1, c2) do
    Card.suit(c1) < Card.suit(c2)
  end
end
