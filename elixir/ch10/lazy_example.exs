defmodule LazyExample do
  def enum_read_words() do
    IO.puts File.read!("/usr/share/dict/words")
      |> String.split
      |> Enum.max_by(&String.length/1)
  end

  def enum_read_words_lazy() do
    IO.puts File.open!("/usr/share/dict/words")
      |> IO.stream(:line)
      |> Stream.map(fn x -> String.replace(x, "\n", "") end)
      |> Enum.max_by(&String.length/1)
  end
end
