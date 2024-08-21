defmodule Assertion do
  defmacro extend(_options \\ []) do
    quote do
      import unquote(__MODULE__)

      def run do
        IO.puts("Running the tests...")
      end
    end
  end
end

defmodule MathTest do
  require Assertion
  Assertion.extend()
end
