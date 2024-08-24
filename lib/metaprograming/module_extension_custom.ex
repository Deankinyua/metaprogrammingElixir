defmodule AssertionExtension do
  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :tests, accumulate: true)

      def run do
        IO.puts("Running the tests (#{inspect(@tests)})")
      end
    end
  end

  # ? Next,we defined The test macro, which first converts the test-case
  # ? description to an atom so that it can serve as a valid function name.

  defmacro test(description, do: test_block) do
    test_func = String.to_atom(description)

    quote do
      @tests {unquote(test_func), unquote(description)}
      def unquote(test_func)(), do: unquote(test_block)
    end
  end
end

defmodule MathTestExtension do
  # * use SomeModule simply invokes the SomeModule.__using__/1 macro
  # * passing the second argument of use as the argument to SomeModule.__using__/1
  # * MathTestExtension takes the AssertionExtension as its input - Meaning of Metaprogramming

  use AssertionExtension
  import Assertion

  test "integers can be added and subtracted" do
    assert 1 + 1 == 2
    assert 2 + 3 == 5
    assert 5 - 5 == 10
  end
end

# Since __using__/1 is typically a macro, all the usual macro rules apply,
# and its return value should be quoted code that is then inserted where use/2 is called.

# Module attributes allow data to be stored in the module at compile time.
