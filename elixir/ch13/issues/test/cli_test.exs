defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1, sort_into_desc_order: 1]

  test "parsing help flags returns :help" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "parsing three options returns those three" do
    assert parse_args(["user1", "project2", "99"]) == {"user1", "project2", 99}
  end

  test "parsing two options returns them and a default count" do
    assert parse_args(["user1", "project2"]) == {"user1", "project2", 4}
  end

  test "sort_into_desc_order works correctly" do
    result = sort_into_desc_order(fake_created_at_list(~w[c a b d]))
    issues = for issue <- result, do: Map.get(issue, "created_at")
    assert issues == ~w[d c b a]
  end

  defp fake_created_at_list(values) do
    for value <- values,
        do: %{"created_at" => value, "other_data" => "asdf"}
  end
end
