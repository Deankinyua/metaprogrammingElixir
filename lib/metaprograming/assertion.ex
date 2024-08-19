defmodule Metaprograming.Assertion do
  # note: Building a mini testing framework in Elixir
  # {:==, [context: Elixir, import: Kernel], [5, 5]}
  # * bind_quoted option passes a binding to the block, ensuring
  # * that the outside bound variables are unquoted only a single time.

  # * The goal for our assert macro is to accept a left-hand side and right-hand side
  # * expression, separated by an Elixir operator, such as assert 1 > 0.
  defmacro assert({operator, _, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Assertion1.Test.assert(operator, lhs, rhs)
    end
  end
end

# By generating a single line of code on line 10 to proxy to Assertion.Test.assert, we
# let the Virtual Machine’s pattern matching take over to report the result of
# each assertion.

# * Proxy - give someone authority to do a task for you

# * try to think about how pattern matching can help guide your implementation.

defmodule Assertion1.Test do
  def assert(:==, lhs, rhs) when lhs == rhs do
    IO.write(".")
  end

  def assert(:==, lhs, rhs) do
    IO.puts("""
    FAILURE:

    Expected: #{lhs}
    to be equal to: #{rhs}
    """)
  end

  def assert(:>, lhs, rhs) when lhs > rhs do
    IO.write(".")
  end

  def assert(:>, lhs, rhs) do
    IO.puts("""
    FAILURE:
    Expected: #{lhs}
    to be greater than: #{rhs}
    """)
  end
end
