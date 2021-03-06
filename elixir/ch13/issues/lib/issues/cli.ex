defmodule Issues.CLI do
  import Issues.TableFormatter, only: [print_table_for_columns: 2]

  @default_count 4
  @moduledoc """
  Handle the command line parsing and dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def process(:help) do
    IO.puts("""
    usage: issues <user> <project> [ count | #{@default_count} ]
    """)

    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_into_desc_order()
    |> last(count)
    |> print_table_for_columns(~w[number created_at title])
  end

  def last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse()
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    IO.puts("Error fetching from Github: #{error["message"]}")
    System.halt(2)
  end

  def sort_into_desc_order(issues) do
    issues
    |> Enum.sort(fn i1, i2 ->
      i1["created_at"] >= i2["created_at"]
    end)
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
