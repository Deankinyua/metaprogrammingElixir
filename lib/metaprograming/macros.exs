defmodule Unless do
  def fun_unless(clause, do: expression) do
    if(!clause, do: expression)
  end

  defmacro macro_unless(clause, do: expression) do
    quote do
      if(!unquote(clause), do: unquote(expression))
    end
  end
end

# macro_unless(true,
# [do: {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["this should never be printed"]}]
# )
