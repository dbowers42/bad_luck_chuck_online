defmodule GameTest do
  use ExUnit.Case, async: true
  doctest BadLuckChuck.Game

  test "the truth" do
    assert 1 + 1 == 2
  end
end
