defmodule HandTest do
  use ExUnit.Case, async: true
  doctest BadLuckChuck.Hand

  test "the truth" do
    assert 1 + 1 == 2
  end
end
