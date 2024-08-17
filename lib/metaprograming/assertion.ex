defmodule Metaprograming.Assertion do
  alias Metaprograming.Assertion
  # {:==, [context: Elixir, import: Kernel], [5, 5]}
  # * bind_quoted option passes a binding to the block, ensuring
  # * that the outside bound variables are unquoted only a single time.
  defmacro assert({operator, _, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Assertion.Test.assert(operator, lhs, rhs)
    end
  end
end
