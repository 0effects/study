defmodule Exercise5 do
  def call_me do
    receive do
      {sender, _msg} ->
        send(sender, {:ok, "Got your message"})
    end

    IO.puts("Child exit")
    raise "Child exit exception"
  end

  def run do
    {pid, _ref} = spawn_monitor(Exercise5, :call_me, [])
    send(pid, {self(), "blah"})

    IO.puts("Parent waiting")
    :timer.sleep(5000)
    IO.puts("Parent stop waiting")

    receive do
      {:ok, response} ->
        IO.puts("Got response [#{response}]")

      other ->
        IO.puts("Got other response")
        IO.inspect(other)
    end
  end
end

Exercise5.run()
