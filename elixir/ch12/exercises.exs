
defmodule Exercise3 do
  def ok!({:ok, data}), do: data
  def ok!({error, _}) do
    raise "ok!: Got an error: #{error}"
  end

  def test do
    IO.puts "This should work: "
    ok! File.open("./fizz_cond.exs")
    IO.puts "This should fail: "
    ok! File.open("./this_file_isnt_here")
  end
end
