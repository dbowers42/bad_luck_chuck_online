defmodule BadLuckChuck do
  alias BadLuckChuck.Game

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Game, [:game_1])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
