defmodule Issues.CLI do
  @default_count 4
  @moduledoc """
  Handle the command line parsing and dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """
  def run(argv) do
    parse_args(argv)
  end

  @doc """
  `argv` can be -h or --help, which returns :help

  Otherwise, it's a github user name, project name, and optionally a count
  of entries to show.

  Returns a tuple of `{user, project, count}` or `:help` if help was requested.
  """
  def parse_args(argv) do
    argv
    |> OptionParser.parse(
      switches: [help: :boolean],
      aliases: [h: :help]
    )
    |> elem(1)
    |> args_to_internal_rep()
  end

  def args_to_internal_rep([user, project, count]) do
    {user, project, String.to_integer(count)}
  end

  def args_to_internal_rep([user, project]) do
    {user, project, @default_count}
  end

  def args_to_internal_rep(_) do
    :help
  end
end
