defmodule BadLuckChuck.DeckSupervisor do
  use Supervisor

  alias BadLuckChuck.Deck

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    decks = [
      worker(Deck, [])
    ]

    supervise(decks, strategy: :simple_one_for_one)
  end

  def decks do
    Supervisor.which_children(__MODULE__)
    |> Enum.map(&elem(&1, 1))
  end

  def create_deck do
    Supervisor.start_child(__MODULE__, [])
  end
end
