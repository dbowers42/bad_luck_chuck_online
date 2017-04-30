defmodule BadLuckChuck.DrawPile do
  @moduledoc """
    The BadLuckChuck.DrawPile module provides functions for managing a pile for
    cards to be drawn from.
  """

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{cards: []}, name: __MODULE__)
  end

  def init(state) do
    {:ok, %{state | cards: populate_cards}}
  end

  def cards do
    GenServer.call(__MODULE__, :cards)
  end

  def handle_call(:cards, _from, state) do
    {:reply, state.cards, state}
  end

  defp populate_cards do
    for deck <- 1..2, suit <- ["c", "d", "h", "s"], rank <- 1..13 do
      String.to_atom(suit <> Integer.to_string(rank))
    end
  end
end
