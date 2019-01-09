defmodule Identicon do
  @moduledoc """
  The one stop module for making an identicon from a piece of string.
  Create a unique image representation for every string that you may pass int.
  """
  def main(inp) do
    inp
    |> get_hash
    |> pick_color
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
    [r, g, b]
  end
end
