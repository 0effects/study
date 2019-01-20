defmodule Spawn2 do
  def greet do
    receive do
      {sender, msg} ->
        send(sender, {:ok, "Hello, #{msg}"})
    end
  end
end

pid = spawn(Spawn2, :greet, [])
send(pid, {self(), "World!"})
#           ^ - What is this? Oh, it's "Sender", so it can send a message back to us..

receive do
  {:ok, message} -> IO.puts(message)
end

send(pid, {self(), "Kermit!"})

receive do
  {:ok, message} -> IO.puts(message)
end
