defmodule Weather.Formatter do
  @moduledoc """
  Responsible for formatting the raw data and printing it to screen.
  """
  def print_columns({:error, _}, _) do
    "oops.."
  end

  def print_columns({:ok, %{"current_observation" => data}}, columns) do
    IO.puts("Current observation for station #{Map.get(data, "station_id")}")
    IO.puts("")

    columns
    |> Enum.map(&get_data_point(data, &1))
    |> Enum.join("\n")
    |> IO.puts()

    IO.puts("")
  end

  def get_data_point(data, column) do
    "#{column}: #{Map.get(data, column)}"
  end
end
