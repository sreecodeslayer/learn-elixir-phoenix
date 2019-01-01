defmodule Cards do
  def hello do
    "Hi user! Welcome to game of cards"
  end

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # Make a combination oof [(value,suits),]

    for suit <- suits do
      for value <- values do
        value
      end
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end
end
