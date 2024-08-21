defmodule AssertionExtension do
  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)

      def run do
        IO.puts("Running the tests...")
      end
    end
  end
end

defmodule MathTest do
  # * use SomeModule simply invokes the SomeModule.__using__/1 macro
  # * passing the second argument of use as the argument to SomeModule.__using__/1

  # Since __using__/1 is typically a macro, all the usual macro rules apply,
  #  and its return value should be quoted code that is then inserted where use/2 is called.
  use AssertionExtension
end
