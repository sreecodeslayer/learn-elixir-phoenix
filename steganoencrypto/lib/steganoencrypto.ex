defmodule Steganoencrypto do
  @moduledoc """
  A simple cli tool that lets you hide any text inside a given image by using the concepts of AES encryption and Steganoencrypto.
  """
  alias Steganoencrypto.AES
  alias Steganoencrypto.Image

  @doc """
  Single entry point for hiding an encrypted message in a given image.

  ## Examples

      Steganoencrypto.write('hide this message', '/path/to/image.png')
      :ok

  """
  def write(text, filepath) do
    text
    |> AES.encrypt()
    |> Image.hide(filepath)
  end

  def read(filepath) do
    filepath
    |> Image.unhide()
    |> AES.decrypt()
  end
end
