defmodule CardTest do
  use ExUnit.Case, async: true
  doctest BadLuckChuck.Card

  @fifteen_point_cards [:c1, :d1, :h1, :s1]

  @ten_point_cards [
    :c10, :c11, :c12, :c13,
    :d10, :d11, :d12, :d13,
    :h10, :h11, :h12, :h13,
    :s10, :s11, :s12, :s13,
  ]

  @five_point_cards [
    :c2, :c3, :c4, :c5, :c6, :c7, :c8, :c9,
    :d2, :d3, :d4, :d5, :d6, :d7, :d8, :d9,
    :h2, :h3, :h4, :h5, :h6, :h7, :h8, :h9,
    :s2, :s3, :s4, :s5, :s6, :s7, :s8, :s9
  ]

  alias BadLuckChuck.Card

  describe "BadLuckChuck.Card.rank/1" do
  end

  describe "BadLuckChuck.Card.suit/1" do
  end

  describe "BadLuckChuck.Card.display_name/1" do

  end

  describe "BadLuckChuck.Card.points/1" do
    test "rank 1" do
      @fifteen_point_cards |> Enum.each(fn card ->
        assert Card.points(card) == 15
      end)
   end

   test "rank 2-9" do
     @five_point_cards |> Enum.each(fn card ->
       assert Card.points(card) == 5
     end)
   end

   test "rank 10-13" do
     # Rank 10-13
     @ten_point_cards |> Enum.each(fn card ->
       assert Card.points(card) == 10
     end)
   end
  end
end
