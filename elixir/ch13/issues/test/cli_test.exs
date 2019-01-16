defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1]

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
end
