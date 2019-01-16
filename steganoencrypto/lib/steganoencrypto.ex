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
    {key, cphtext} = AES.encrypt(text)

    case Image.hide(cphtext, filepath) do
      :ok -> IO.puts("Please save your encryption key securely:\n#{key}")
    end
  end

  def read(key, filepath) do
    res =
      filepath
      |> Image.unhide()
      |> AES.decrypt(key)

    case res do
      {:ok, clear_text} -> IO.puts("Here is secret message from image:\n#{clear_text}")
      {:error, _} -> IO.puts("Oops, something unexpected happened!!")
    end
  end
end
