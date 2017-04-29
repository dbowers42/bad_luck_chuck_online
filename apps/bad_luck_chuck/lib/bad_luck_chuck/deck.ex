defmodule BadLuckChuck.Deck do
  @moduledoc """
    The BadLuckChuck.Deck module manages a collection of cards as deck
    that has been put into play.
  """
  alias BadLuckChuck.Card
  alias BadLuckChuck.Sequencer

  import BadLuckChuck.Pile, only: [same_rank?: 1, same_suit?: 1]

  @doc """
    Returns true if a collection of cards has at least 3 cards

      iex> BadLuckChuck.Deck.minimum_cards?([:c1, :c2, :c3])
      true

      iex> BadLuckChuck.Deck.minimum_cards?([:c1, :c2])
      false
  """
  def minimum_cards?(cards) when is_list(cards) do
     Enum.count(cards) >= 3
  end

  @doc """
    Returns true only if a collection of 3 or more cards all have the same rank
    regardless of their suit.

      iex> BadLuckChuck.Deck.book?([:s1, :h1, :d1])
      true

      iex> BadLuckChuck.Deck.book?([:s1, :h2, :d1])
      false

      iex> BadLuckChuck.Deck.book?([:s1, :s2])
      false
  """
  def book?(cards) do
    minimum_cards?(cards) && same_rank?(cards)
  end

  @doc """
    Returns true only if a collection of 3 or more cards of all the same suit
    can be arranged sequentially by rank with out gaps

      iex> BadLuckChuck.Deck.run?([:c1, :c2, :c3])
      true

      iex> BadLuckChuck.Deck.run?([:c1, :c2, :h3])
      false

      iex> BadLuckChuck.Deck.run?([:h1, :h12, :h13])
      true

      iex> BadLuckChuck.Deck.run?([:s1, :s3, :s2])
      true
  """
  def run?(cards) do
    minimum_cards?(cards) && same_suit?(cards) && Sequencer.sequential?(cards)
  end

  @doc """
    Returns a pair of card collections produced by splitting a source collections
    by the first occurance of the card specified. The card specified will be a
    member of the first member of the returned pair
  """
  def cut(cards, divider) when is_list(cards) and is_atom(divider) do
     index = Enum.find_index(cards, &(&1 == divider)) + 1

     Enum.split_while(cards, fn card -> card != Enum.at(cards, index) end)
  end

  @doc """
    Returns the total point value of a collection of cards.
    Aces are worth 15 points. Face cards and Tens are worth 10 points.
    All other cards are worth 5 points.

      iex> BadLuckChuck.Deck.points([:c1, :c7, :c13])
      30

      iex> BadLuckChuck.Deck.points([:c4, :c5, :c6])
      15

      iex> BadLuckChuck.Deck.points([:c1, :h1, :d1])
      45

      iex> BadLuckChuck.Deck.points([:h10, :h11, :h13])
      30
  """
  def points(cards) when is_list(cards) do
    BadLuckChuck.Pile.points(cards)
  end
end
