defmodule BadLuckChuck.Game do
  @moduledoc """
  """

  alias BadLuckChuck.{PlayerSupervisor, DeckSupervisor}
  alias BadLuckChuck.{Player, Board, DrawPile}

  use GenServer

  def start_link(game_id) when is_atom(game_id) do
    GenServer.start_link(__MODULE__, %{}, name: game_id)
  end

  def init(state) do
    import Supervisor.Spec

    children = [
      supervisor(PlayerSupervisor, []),
      supervisor(DeckSupervisor, []),
      worker(Board, [:active_board]),
      worker(DrawPile, [])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)

    {:ok, state}
  end
end
