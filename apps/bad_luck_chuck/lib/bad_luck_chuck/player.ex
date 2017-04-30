defmodule BadLuckChuck.Player do
  @moduledoc """
      The BadLuckChuck.Player module provides functions to respond to player
      actions
  """

  use GenServer

  def start_link(screen_name) do
    name = String.to_atom("#{__MODULE__}_#{screen_name}") |> IO.inspect
    GenServer.start_link(__MODULE__, %{screen_name: screen_name}, name: name)
  end
end
