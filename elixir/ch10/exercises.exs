defmodule Exercises do
  ## Implement All? / ListsAndRecursion-5
  def all?([ head | tail], predicate) do
    if predicate.(head) do
      all?(tail, predicate)
    else
      false
    end
  end

  def all?([], _), do: true

  ## Implement Each / ListsAndRecursion-5
  def each([head | tail], action) do
    action.(head)
    each(tail, action)
  end
  def each([], _), do: nil

  ## Implement Filter
  def filter([head | tail], predicate) do
    if predicate.(head) do
      [ head | filter(tail, predicate) ]
    else
      filter(tail, predicate)
    end
  end
  def filter([], _), do: []

  ## Implement Split (?)
  def split(list, size) do
    split([], list, size)
  end

  def split(outer_list, [], _) do
    {outer_list, []}
  end
  def split(outer_list, inner_list, 0) do
    {outer_list, inner_list}
  end
  def split(outer_list, [head | tail], size) do
    split(outer_list ++ [head], tail, size - 1)
  end

  ## Implement Take
  def take(list, num) do
    take(list, num, 0)
  end

  def take(_list, num, i) when i >= num do
    []
  end
  def take([head | tail], num, i) do
    [head | take(tail, num, i+1)]
  end

  ## Implement flatten
  def flatten([head | tail]) when is_list(head) do
    flatten(head) ++ flatten(tail)
  end
  def flatten([head | tail]) when not is_list(head) do
    [head | flatten(tail)]
  end
  def flatten([]) do
    []
  end

  ## ListsAndRecursion7 BEGIN
  def span(from, to) when from < to do
    [ from | span(from + 1, to) ]
  end

  def span(from, to) when from >= to do
    [from]
  end

  def primeToN(n) do
    for x <- span(2, n), is_prime(x), do: x
  end

  def is_prime(x), do: is_prime(x, div(x, 2))
  defp is_prime(_x, 1), do: true
  defp is_prime(x, divisor) do
    if rem(x, divisor) == 0 do
      false
    else
      is_prime(x, divisor-1)
    end
  end
  ## ListsAndRecursion7 END
end
