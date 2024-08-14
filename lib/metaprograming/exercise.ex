defmodule Metaprograming.Exercise do
  # note: Define an unless macro without depending on Kernel.if,
  # note: by using other constructs in Elixir for control flow.
  defmacro unless(clause, do: expression) do
    quote do
      case !unquote(clause) do
        x when x in [false, nil] ->
          nil

        _ ->
          unquote(expression)
      end
    end
  end
end

#  ast =
#   quote do
#     if(!unquote(clause), do: unquote(expression))
#   end

# expanded_once =
#   if !(2 == 5) do
#     "block entered"
#   end

# * Just a Macro.to_string(expanded_fully)

# case !(2 == 5) do
# x when Kernel.in(x, [false, nil]) -> nil
#   _ -> "block entered"
# end
