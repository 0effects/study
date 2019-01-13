# Exercise: ModulesAndFunctions-6
defmodule Chop do
  def guess(actual, min..max) do
    myguess = div((min + max), 2)
    IO.puts "Is it #{myguess}"

    {outcome, new_range} = adjust_range(actual, myguess, min..max)
    if outcome == :guess_again do
      guess(actual, new_range)
    else
      myguess
    end
  end

  defp adjust_range(actual, myguess, min.._max) when myguess > actual do
    IO.puts "Guess is too high"
    {:guess_again, min..myguess}
  end

  defp adjust_range(actual, myguess, _min..max) when myguess < actual do
    IO.puts "Guess is too low"
    {:guess_again, myguess..max}
  end

  defp adjust_range(actual, myguess, _range) when myguess == actual do
    IO.puts "Guess is correct"
    {:correct, myguess..myguess}
  end
end
