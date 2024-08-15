defmodule Metaprograming.While do
  # note: Creating a while loop in elixir as it does not have one

  alias Metaprograming.While

  defmacro while(expression, do: block) do
    quote do
      try do
        # * Stream.cycle/1 Creates a stream that cycles through the given enumerable, infinitely.
        for _ <- Stream.cycle([:ok]) do
          if unquote(expression) do
            unquote(block)
          else
            While.break()
          end
        end
      catch
        :break -> :ok
      end
    end
  end

  def break, do: throw(:break)
end

# run_loop = fn ->
#   pid = spawn(fn -> :timer.sleep(4000) end)

#   While.while Process.alive?(pid) do
#     IO.puts("#{inspect(:erlang.time())} Stayin' alive!")
#     :timer.sleep(1000)
#   end
# end
