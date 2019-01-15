defmodule Exercises do
  # StringsAndBinaries-1
  def printable([]), do: true
  def printable([head | _tail]) when head < 32 or head > 126, do: false
  def printable([_head | tail]), do: printable(tail)

  # StringsAndBinaries-2
  def anagram?(word1, word2), do: Enum.sort(word1) == Enum.sort(word2)

  # StringsAndBinaries-3
  # Because the first element is another nested list.

  # StringsAndBinaries-4
  def calculate(expression) do
    [x1c, _, op, _, x2c] = expression |> Enum.chunk_by(fn x -> x != 32 end)
    {x1, ""} = x1c |> to_string |> Integer.parse
    {x2, ""} = x2c |> to_string |> Integer.parse
    calculate(x1, op, x2)
  end
  def calculate(x1, '+', x2), do: x1 + x2
  def calculate(x1, '-', x2), do: x1 - x2
  def calculate(x1, '*', x2), do: x1 * x2
  def calculate(x1, '/', x2), do: x1 / x2

  # StringsAndBinaries-5
  def center(string_list) do
    max_width = string_list |> Enum.max_by( &String.length/1 ) |> String.length
    string_list
    |> Enum.each(fn string -> print_center(string, max_width) end)
  end
  def print_center(string, max_width) do
    extra_space = max_width - String.length(string)
    indent_n = div(extra_space, 2)
    indent = String.duplicate(" ", indent_n)
    IO.puts (indent <> string)
  end

  # StringsAndBinaries-6
  def capitalize_sentences(input) do
    input 
    |> String.split(". ") 
    |> Enum.map( fn x -> String.capitalize(x) end ) 
    |> Enum.join(". ")
  end

  # StringsAndBinaries-7
  def ex7 do
  end
end
