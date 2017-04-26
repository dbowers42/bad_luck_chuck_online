defmodule BadLuckChuck.Deck do
  use GenServer
  alias BadLuckChuck.Card

  import BadLuckChuck.Pile, only: [sort: 2]

end
