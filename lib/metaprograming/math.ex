defmodule Metaprograming.Math do
  # {:+, [context: Elixir, import: Kernel], [5, 2]}
  defmacro say({:+, _, [lhs, rhs]}) do
    quote do
      lhs = unquote(lhs)
      rhs = unquote(rhs)
      result = lhs + rhs
      IO.puts("#{lhs} plus #{rhs} is #{result}")
      result
    end
  end

  # {:*, [context: Elixir, import: Kernel], [8, 3]}
  defmacro say({:*, _, [lhs, rhs]}) do
    quote do
      lhs = unquote(lhs)
      rhs = unquote(rhs)
      result = lhs * rhs
      IO.puts("#{lhs} times #{rhs} is #{result}")
      result
    end
  end

  defmacro unless(expression, do: block) do
    # * This Transformation is known as a macro expansion
    # * The final AST returned from unless is expanded within the caller’s context at compile time.
    quote do
      if !unquote(expression), do: unquote(block)
    end
  end
end

# quote do
#   defmodule MyModule do
#     def hello, do: "World"
#   end
# end
