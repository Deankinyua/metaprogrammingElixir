defmodule Metaprograming.Debugger do
  # note: exploring the importance of bind_quoted

  # *Important: if you are reading the application environment at compilation time,
  # * for example, inside the module definition instead of inside of a function,
  # * see compile_env!/2 instead.
  defmacro log(expression) do
    # * gets the value for the key :log_level of the application debugger
    # * The function call remote_api_call.() will be evoked once
    if Application.get_env(:debugger, :log_level) == :debug do
      quote bind_quoted: [expression: expression] do
        IO.puts("=================")
        IO.inspect(expression)
        IO.puts("=================")
        expression
      end
    else
      expression
    end
  end
end

# expression = "calling the remote api"

# note: The following quoted expressons are equivalent
# quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
#   Assertion.Test.assert(operator, lhs, rhs)
# end

# quote do
#   Assertion.Test.assert(unquote(operator), unquote(lhs), unquote(rhs))
# end
