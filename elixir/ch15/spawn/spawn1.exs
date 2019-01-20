defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} ->
        send(sender, {:ok, "Hello, #{msg}"})
    end
  end
end

pid = spawn(Spawn1, :greet, [])
send(pid, {self(), "World!"})
#           ^ - What is this? Oh, it's "Sender", so it can send a message back to us..

receive do
  {:ok, message} -> IO.puts(message)
end
