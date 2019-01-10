defmodule Identicon do
  @moduledoc """
  The one stop module for making an identicon from a piece of string.
  Create a unique image representation for every string that you may pass int.
  """
  def main(inp) do
    inp
    |> get_hash
    |> pick_color
    |> build_grid
  end

  @doc """
  Get a hash value for an input string
  """
  def get_hash(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  @doc """
  Pick an RGB list given a struct
  """
  def pick_color(img) do
    # {rgblist, _junk} = Enum.split(img.hex, 3)
    # rgblist
    [r, g, b | _remain] = img.hex
    # %Identicon.Image{hex: img.hex, rgb: {r, g, b]}} # No
    %Identicon.Image{img | rgb: {r, g, b}}
  end

  @doc """
  Picks up the image struct, makes chunks of list for every 3 elements
  """
  def build_grid(img) do
    img.hex
    |> Enum.chunk_every(3, 3, :discard)
    |> mirror_row
  end

  def mirror_row(current_row) do
    # current_row = [145,46,200]
    [first, second | _tail] = current_row

    # returns as [145,46,200,46,145]
    current_row ++ [second, first]
  end
end
