defmodule Cards do
  def hello do
    "Hi user! Welcome to game of cards"
  end

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # Make a combination of [(value,suits),]
    # Using nested loops makes its own list for th outer loop
    # [
    #   ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds"],
    #   ["Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds"],
    #   ["Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds"],
    #   ["Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamonds"],
    #   ["Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamonds"]
    # ]

    # for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end 
    # end
    # Recursively pull out and flatten the list

    # iex(25)> List.flatten(Cards.create_deck)
    # ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
    #  "Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds",
    #  "Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds",
    #  "Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamonds",
    #  "Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamonds"]

    # The better method right from start rather than doing double work
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, size) do
    # Splits the deck and index 0 will have size count of elements
    # Returns a tuple {[my hand], [the rest]}
    Enum.split(deck, size)
  end
end
