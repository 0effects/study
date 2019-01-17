defmodule Weather.WeatherGov do
  @moduledoc """
  Handles fetching data from weather.gov and parsing it.
  """
  @user_agent [{"User-agent", "Elixir Weather Fetcher"}]

  def fetch(station_code) do
    station_code
    |> station_url()
    |> HTTPoison.get(@user_agent)
    |> handle_response()
  end

  def station_url(station_code) do
    # TODO - Remove all non-alpha chars from Station_Code
    # Or guard clause causes failure?
    "https://w1.weather.gov/xml/current_obs/#{station_code}.xml"
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    success = status_code |> check_for_error()
    parse_if_needed({success, body})
  end

  def parse_if_needed({:error, _}), do: {:error, nil}
  def parse_if_needed({:ok, body}), do: {:ok, parse(body)}

  def parse(body) do
    body |> XmlToMap.naive_map()
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error
end
