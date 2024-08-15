defmodule Metaprograming.While do
  # note: Creating a while loop in elixir as it does not have one

  defmacro while(expression, do: block) do
    quote do
      for _ <- Stream.cycle([:ok]) do
        if unquote(expression) do
          unquote(block)
        else
          # break out of loop
        end
      end
    end
  end
end
