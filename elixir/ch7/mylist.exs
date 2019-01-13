defmodule MyList do
  def len( [] ), do: 0
  def len( [_head | tail] ), do: 1 + len(tail)

  def square( [] ), do: []
  def square( [head | tail] ), do: [ head * head | square(tail) ]

  def add_one( [] ), do: []
  def add_one( [head | tail] ), do: [ head + 1 | add_one(tail) ]

  def map( [], _f ), do: []
  def map( [head | tail], f ), do: [ f.(head) | map(tail, f) ]

  # Exercise: ListsAndRecursion-1
  def mapsum( list, f ), do: mapsum(list, f, 0)
  def mapsum( [], _f, acc ), do: acc
  def mapsum( [head | tail], f, acc), do: mapsum(tail, f, acc + f.(head))

  # Exercise: ListsAndRecursion-2
  def mymax( list ), do: mymax(list, nil)
  def mymax( [], current_max), do: current_max
  def mymax( [head | tail], current_max) when current_max == nil or head > current_max do
    mymax(tail, head)
  end
  def mymax( [head | tail], current_max) when head <= current_max, do: mymax(tail, current_max)

  # Exercise: ListsAndRecursion-3
  def caesar(list, offset) do
    list |> Enum.map(fn x -> shift(x, offset) end)
  end

  defp shift(char, offset) do
    newchar = char + offset
    rem((newchar - 97), 26) + 97
  end

  # Exercise: ListsAndRecursion-4
  def span(from, to) when from < to do
    [ from | span(from + 1, to) ]
  end

  def span(from, to) when from >= to do
    [from]
  end
end
