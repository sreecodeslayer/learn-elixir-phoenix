defmodule Identicon do
  @moduledoc """
  The one stop module for making an identicon from a piece of string.
  Create a unique image representation for every string that you may pass int.
  """
  def main(inp) do
    inp
    |> get_hash
  end

  @doc """
  Get a hash value for an input string
  """
  def get_hash(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list()
  end
end
