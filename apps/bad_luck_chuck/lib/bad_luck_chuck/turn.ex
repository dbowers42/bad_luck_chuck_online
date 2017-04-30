defmodule BadLuckChuck.Turn do
  @moduledoc """
    The BadLuckChuck.Turn module provides functions for tracking moves made by
    a player for a turn.
  """

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end
end
