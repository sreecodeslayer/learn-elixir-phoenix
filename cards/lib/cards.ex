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

  @doc """
  Shuffle a deck of cards
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Check if a deck contains a specific card.  
  This function takes in two arguments `deck`, and `card`.  
  The `deck` argument requires the list of cards as in a deck of cards.  
  The `card` argument takes the card to be checked for.

  ## Example

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck,"Ace of Spades")
      true
  """
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

  @doc """
  Save an existing deck into a binary file.
  This function takes in two arguments `deck`, and `filename`.  
  The `deck` argument requires the list of cards as in a deck of cards.  
  The `filename` argument indicates complete path or filename to save the file as.

  ## Example

      iex> deck = Cards.create_deck
      iex> Cards.save(deck,'newdeck.bin')
      :ok

  """
  def save(deck, filename) do
    bin = :erlang.term_to_binary(deck)
    File.write(filename, bin)
  end

  @doc """
  Load an existing deck from a binary file.
  This function takes in an argument `filename`.  
  The `filename` argument indicates complete path or filename to load the file from.

  ## Example

      iex> saveddeck = Cards.load('newdeck.bin')
      iex> saveddeck
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
      "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
      "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
      "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
      "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, file} -> :erlang.binary_to_term(file)
      {:error, :enoent} -> "File not found"
    end
  end

  @doc """
  Create a hands of card from deck.
  This function takes in an argument `handsize` of type `int`.  
  The `handsize` argument indicates how many hands to shuffle and deal for the cards game.

  ## Example

      iex> {hand,remains} = Cards.create_hand(1)
      iex> hand
      ["Two of Diamonds"]
      iex> remains
      ["Three of Hearts", "Four of Hearts", "Ace of Clubs", "Three of Spades",
       "Ace of Hearts", "Five of Hearts", "Four of Spades", "Three of Clubs",
       "Four of Clubs", "Ace of Diamonds", "Two of Clubs", "Three of Diamonds",
       "Four of Diamonds", "Two of Hearts", "Five of Clubs", "Five of Spades",
       "Five of Diamonds", "Two of Spades", "Ace of Spades"]
  """
  def create_hand(handsize) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(handsize)
  end
end
