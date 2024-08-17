defmodule Metaprograming.Debugger do
  # note: exploring the importance of bind_quoted
  defmacro log(expression) do
    if Application.get_env(:debugger, :log_level) == :debug do
      quote do
        IO.puts("=================")
        IO.inspect(unquote(expression))
        IO.puts("=================")
        unquote(expression)
      end
    else
      expression
    end
  end
end


# note: The following quoted expressons are equivalent
# quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
#   Assertion.Test.assert(operator, lhs, rhs)
# end

# quote do
#   Assertion.Test.assert(unquote(operator), unquote(lhs), unquote(rhs))
# end
