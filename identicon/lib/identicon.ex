defmodule Identicon do
  import Integer

  @moduledoc """
  The one stop module for making an identicon from a piece of string.
  Create a unique image representation for every string that you may pass int.
  """
  def main(inp) do
    inp
    |> get_hash
    |> pick_color
    |> build_grid
    |> filter_odd_sqrs
    |> build_pixelmap
    |> draw
    |> save(inp)
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
    grid =
      img.hex
      |> Enum.chunk_every(3, 3, :discard)
      # Pass a reference of mirror_row to enum's map
      |> Enum.map(&mirror_row/1)
      # Flatten the list to make it less complex iteration
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{img | grid: grid}
  end

  def mirror_row(current_row) do
    # current_row = [145,46,200]
    [first, second | _tail] = current_row

    # returns as [145,46,200,46,145]
    current_row ++ [second, first]
  end

  def filter_odd_sqrs(img) do
    grid =
      img.grid
      |> Enum.filter(fn {num, _index} -> Integer.is_even(num) end)

    %Identicon.Image{img | grid: grid}
  end

  def build_pixelmap(img) do
    # to get x , we use rem(index,5)*50
    # to get y , we use div(index,5)*50
    pxl_map =
      Enum.map(img.grid, fn {_num, index} ->
        horizontal = rem(index, 5) * 100
        vertical = div(index, 5) * 100

        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 100, vertical + 100}
        {top_left, bottom_right}
      end)

    %Identicon.Image{img | pixel_map: pxl_map}
  end

  def draw(%Identicon.Image{rgb: rgb, pixel_map: pixel_map}) do
    image = :egd.create(500, 500)
    filler = :egd.color(rgb)

    Enum.each(pixel_map, fn {top_left, bottom_right} ->
      :egd.filledRectangle(image, top_left, bottom_right, filler)
    end)

    :egd.render(image)
  end

  def save(img_obj, filename) do
    File.write("#{filename}.png", img_obj)
  end
end
