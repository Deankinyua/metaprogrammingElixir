defmodule Assertion.Test do
  # note: Building a mini testing framework in Elixir

  # * Proxy - give someone authority to do a task for you

  def run(tests, module) do
    Enum.each(tests, fn {test_func, description} ->
      case apply(module, test_func, []) do
        :ok ->
          IO.write(".")

        {:fail, reason} ->
          IO.puts("""

          ===============================================
          FAILURE: #{description}
          ===============================================
          #{reason}
          """)
      end
    end)
  end

  def assert(:==, lhs, rhs) when lhs == rhs do
    IO.write(".")
  end

  def assert(:==, lhs, rhs) do
    # * IO.puts => Writes item to the given device, similar to IO.write/2,
    # * but adds a newline at the end.
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
