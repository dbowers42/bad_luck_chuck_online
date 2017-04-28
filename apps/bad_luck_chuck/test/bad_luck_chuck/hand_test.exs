defmodule HandTest do
  use ExUnit.Casee, async: true
  doctest BadLuckChuck.Hand

  test "the truth" do
    assert 1 + 1 == 2
  end
end
