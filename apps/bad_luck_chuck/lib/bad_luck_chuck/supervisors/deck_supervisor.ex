defmodule BadLuckChuck.DeckSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    decks = [
      worker(Player, [])
    ]

    supervise(decks, strategy: :simple_one_for_one)
  end

  def create_deck(deck_id) do
    
  end
end
