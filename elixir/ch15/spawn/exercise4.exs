defmodule Exercise4 do
  def call_me do
    receive do
      {sender, _msg} ->
        send(sender, {:ok, "Got your message"})
    end

    IO.puts("Child exit")
    raise "Child exit exception"
  end

  def run do
    pid = spawn_link(Exercise4, :call_me, [])
    send(pid, {self(), "blah"})

    IO.puts("Parent waiting")
    :timer.sleep(5000)
    IO.puts("Parent stop waiting")

    receive do
      {:ok, response} ->
        IO.puts("Got response [#{response}]")
    end
  end
end

Exercise4.run()
