defmodule Weather.CLI do
  import Weather.Formatter, only: [print_columns: 2]
  @default_station "KDTO"

  @moduledoc """
  Handle command line parsing and dispatch to the main
  bits of the program.
  """

  def main(argv) do
    argv
    |> parse_args()
    |> process()
  end

  def process(:help) do
    IO.puts("""
    usage: weather [station_code]

    Defaults to station #{@default_station} if not provided.
    """)

    System.halt(0)
  end

  def process({station_code}) do
    station_code
    |> Weather.WeatherGov.fetch()
    |> print_columns(~w[temperature_string location weather wind_string])
  end

  def parse_args(argv) do
    argv
    |> OptionParser.parse(
      switches: [help: :boolean],
      aliases: [h: :help]
    )
    |> args_to_internal_rep()
  end

  def args_to_internal_rep({[], [station_code], _}), do: {station_code}
  def args_to_internal_rep({[], [], _}), do: {@default_station}
  def args_to_internal_rep({[help: true], _, _}), do: :help
  def args_to_internal_rep(_), do: :help
end
