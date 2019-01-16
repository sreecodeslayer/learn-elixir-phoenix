defmodule Steganoencrypto.AES do
  import ExCrypto

  @doc """
  key + clear_text -> init_vec + cipher_text
  """
  def encrypt(clear_text) do
    {:ok, key} = ExCrypto.generate_aes_key(:aes_256, :bytes)

    case ExCrypto.encrypt(key, clear_text) do
      {:ok, {iv, cipher_text}} ->
        {key, Base.encode64(iv) <> ":" <> Base.encode64(cipher_text)}

      {:error, _reason} ->
        ""
    end
  end

  def decrypt(cipher_text, key) do
    [iv, cipher_text] = String.split(cipher_text, ":")
    iv = Base.decode64(iv)
    cipher_text = Base.decode64(cipher_text)

    case ExCrypto.decrypt(key, iv, cipher_text) do
      {:ok, clear_text} -> clear_text
      {:error, _reason} -> ""
    end
  end
end
