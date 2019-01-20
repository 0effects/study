# Exercise: WorkingWithMultipleProcesses-2
#
# Are the replies received in deterministic order in theory?
#    - I don't really understand the theory well enough to say.
# Are the replies received in deterministic order in practice?
#    - No, sometimes they flip.
# How could you make it so?
#    - You could add a delay between sending the messages, but
#    that wouldn't be guarenteed.
#    - You could only send the second message after the first is received.
#    Done in this file.

defmodule Exercise do
  def listen do
    receive do
      {sender, msg} ->
        send(sender, {:ok, "Got your message #{msg}"})
    end
  end
end

pid1 = spawn(Exercise, :listen, [])
pid2 = spawn(Exercise, :listen, [])

send(pid1, {self(), "Fred"})
# send(pid2, {self(), "Betty"})

receive do
  {:ok, message} ->
    IO.puts(message)
    send(pid2, {self(), "Betty"})
end

receive do
  {:ok, message} -> IO.puts(message)
end

# spawn(Class, method, params) --> returns pid
# receive (case/pattern match against stuff sent)
# send(pid, ..whatever..)
# self() # my pid
