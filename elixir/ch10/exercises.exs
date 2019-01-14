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

  def take([head | tail], num, i) when i >= num do
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
end
