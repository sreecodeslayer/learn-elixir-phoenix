defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create deck" do
    deck = [
      "Ace of Spades",
      "Two of Spades",
      "Three of Spades",
      "Four of Spades",
      "Five of Spades",
      "Ace of Clubs",
      "Two of Clubs",
      "Three of Clubs",
      "Four of Clubs",
      "Five of Clubs",
      "Ace of Hearts",
      "Two of Hearts",
      "Three of Hearts",
      "Four of Hearts",
      "Five of Hearts",
      "Ace of Diamonds",
      "Two of Diamonds",
      "Three of Diamonds",
      "Four of Diamonds",
      "Five of Diamonds"
    ]

    assert Cards.create_deck() == deck
  end
end
