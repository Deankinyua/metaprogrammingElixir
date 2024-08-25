defmodule AssertionExtension do
  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
      # Module attributes allow data to be stored in the module at compile time.
      Module.register_attribute(__MODULE__, :tests, accumulate: true)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      # This is what we mean by temporary storage: after the module is compiled,
      # the module attribute is discarded, except for the functions that have read the attribute.
      def run, do: Assertion.Test.run(@tests, __MODULE__)
    end
  end

  #  Next,we defined The test macro, which first converts the test-case
  #  description to an atom so that it can serve as a valid function name.

  defmacro test(description, do: test_block) do
    test_func = String.to_atom(description)

    quote do
      # * the test_func reference and description are accumulated in the @tests module attribute
      @tests {unquote(test_func), unquote(description)}
      def unquote(test_func)(), do: unquote(test_block)
    end
  end

  # * The goal for our assert macro is to accept a left-hand side and right-hand side
  # * expression, separated by an Elixir operator, such as assert 1 > 0.
  defmacro assert({operator, _, [lhs, rhs]}) do
    # * bind_quoted option passes a binding to the block, ensuring
    # * that the outside bound variables are unquoted only a single time.
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Assertion.Test.assert(operator, lhs, rhs)
    end
  end
end

defmodule MathTestExtension do
  # * use SomeModule simply invokes the SomeModule.__using__/1 macro
  # * passing the second argument of use as the argument to SomeModule.__using__/1

  use AssertionExtension
  # import Assertion.Test
  test "integers can be added and subtracted" do
    assert 2 + 3 == 5
    assert 5 - 5 == 10
  end

  test "integers can be multiplied and divided" do
    assert 5 * 5 == 25
    assert 10 / 10 == 5
  end
end
