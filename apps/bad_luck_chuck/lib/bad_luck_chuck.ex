defmodule BadLuckChuck do
  alias BadLuckChuck.Game

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Game, [:game_1])
    ]

    {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)

    alias BadLuckChuck.DeckSupervisor
    alias BadLuckChuck.Deck

    DeckSupervisor.create_deck()
      DeckSupervisor.create_deck()
        DeckSupervisor.create_deck()
    DeckSupervisor.decks() |> IO.inspect

    {:ok, pid}
  end
end
