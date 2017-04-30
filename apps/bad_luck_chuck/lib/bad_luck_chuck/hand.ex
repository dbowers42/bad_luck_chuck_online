defmodule BadLuckChuck.Hand do
  @moduledoc """
    The BadLuckChuck.Hand module provides functions to keep track of what cards
    are in a players hand.
  """
  use GenServer

  import BadLuckChuck.Pile, only: [sort: 2]

  def start_link(hand_id) when is_atom(hand_id) do
    GenServer.start_link(__MODULE__, %{cards: []}, name: hand_id)
  end

  def cards(hand) do
    IO.inspect hand
    GenServer.call(hand, :cards)
  end

  def add_card(hand, card) do
    GenServer.cast(hand, {:add_card, card})
  end

  def handle_call(:cards, _from, state) do
    {:reply, state.cards, state}
  end

  def handle_cast({:add_card, card}, state) do
    {:noreply, %{state | cards: [card| state.cards]}}
  end
end
