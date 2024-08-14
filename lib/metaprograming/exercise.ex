defmodule Metaprograming.Exercise do
  defmacro unless(clause, do: expression) do
    quote do
      if(!unquote(clause), do: unquote(expression))
    end
  end
end

# ast =
#   quote do
#     if(!unquote(clause), do: unquote(expression))
#   end

expanded_once = if !(2 == 5) do  "block entered" end

case !(2 == 5) do
  x when x in [false, nil] ->
    nil

  _ ->
    "block entered"
end
