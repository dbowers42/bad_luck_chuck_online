defmodule BadLuckChuck.Board do
  @moduledoc """
    The BadLuckChuck.Board module provides functions to manage decks of cards
    that have been played on a board
  """
  use GenServer

  def start_link(board_id) when is_atom(board_id) do
    GenServer.start_link(__MODULE__, %{decks: []}, name: board_id)
  end

  def decks(deck) do
    GenServer.call(deck, :decks)
  end

  def add_deck(deck) do
    GenServer.cast(__MODULE__, {:add_deck, deck})
  end

  def handle_call(:decks, _from, state) do
    {:reply, state.decks, state}
  end

  def handle_cast({:add_deck, deck}, state) do
    {:noreply, %{state | decks: [deck | state.decks]}}
  end
end
