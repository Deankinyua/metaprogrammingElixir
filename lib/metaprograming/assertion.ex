defmodule Metaprograming.Assertion do
  alias Metaprograming.Assertion
  # {:==, [context: Elixir, import: Kernel], [5, 5]}
  # * bind_quoted option passes a binding to the block, ensuring
  # * that the outside bound variables are unquoted only a single time.

  # * The goal for our assert macro is to accept a left-hand side and right-hand side
  # * expression, separated by an Elixir operator, such as assert 1 > 0.
  defmacro assert({operator, _, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Assertion.Test.assert(operator, lhs, rhs)
    end
  end
end
