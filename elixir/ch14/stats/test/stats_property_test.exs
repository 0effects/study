defmodule StatsPropertyTest do
  use ExUnit.Case
  use ExUnitProperties

  describe "Stats on lists of ints do" do
    property "single element lists are their own sum" do
      check all number <- integer() do
        assert Stats.sum([number]) == number
      end
    end

    property "count not negative" do
      check all l <- list_of(integer()) do
        assert Stats.count(l) >= 0
      end
    end

    property "sum equals average times count (nonempty)" do
      check all l <- list_of(integer()) |> nonempty do
        assert_in_delta(
          Stats.sum(l),
          Stats.count(l) * Stats.average(l),
          1.0e-6
        )
      end
    end
  end
end
