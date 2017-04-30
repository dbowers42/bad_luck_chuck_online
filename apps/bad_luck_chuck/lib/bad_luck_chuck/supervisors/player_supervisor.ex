defmodule BadLuckChuck.PlayerSupervisor do
  use Supervisor

  alias BadLuckChuck.Player

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    players = [
      worker(Player, [])
    ]

    supervise(players, strategy: :simple_one_for_one)
  end

  def create_player(screen_name) do
    Supervisor.start_child(__MODULE__, [screen_name])
  end
end
