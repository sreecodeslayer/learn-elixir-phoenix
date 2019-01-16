defmodule Steganoencrypto.Image do
  def hide(ciphertext, filepath) do
    IO.puts("ENC TEXT :: #{ciphertext}")
  end

  def unhide(filepath) do
    IO.puts("IMG :: #{filepath}")
    message = "unhidden message"
  end
end
