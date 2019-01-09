defmodule Cards do
  @moduledoc """
  The Cards module provides a variety of functionalities dealing with a game of cards
  """

  @doc """
  Returns a list of strings representing a deck of cards
  """
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

  @doc """
  Divides a deck into a hand and remainder deck.
  This function takes in two arguments `deck`, and `size`.  
  The `deck` argument requires the list of cards as in a deck of cards.  
  The `size` argument indicates how many cards should go into the single hand.

  ## Example

      iex> deck = Cards.create_deck
      iex> {hand,otherdeck} = Cards.deal(deck,1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, size) do
    # Splits the deck and index 0 will have size count of elements
    # Returns a tuple {[my hand], [the rest]}
    Enum.split(deck, size)
  end

  def save(deck, filename) do
    bin = :erlang.term_to_binary(deck)
    File.write(filename, bin)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, file} -> :erlang.binary_to_term(file)
      {:error, :enoent} -> "File not found"
    end
  end

  def create_hand(handsize) do
    # deck = Cards.create_deck()
    # deck = Cards.shuffle(deck)
    # Cards.deal(deck, handsize)
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(handsize)
  end
end
