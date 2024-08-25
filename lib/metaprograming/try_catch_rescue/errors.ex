defmodule Metaprograming.Errors do
  require Logger

  # ? Learning about the use of errors, throws and exits

  # * Errors are reserved for unexpected and/or exceptional situations
  def error do
    try do
      # ... some code ...
    rescue
      e ->
        Logger.error(Exception.format(:error, e, __STACKTRACE__))
        reraise e, __STACKTRACE__
    end
  end

  # * Throws are used for control flow in situations where
  # * it is NOT possible to retrieve a value unless by using throw and catch.
  def throw do
    try do
      Enum.each(-50..50, fn x ->
        if rem(x, 13) == 0, do: throw(x)
      end)

      "Got nothing"
    catch
      x -> "Got #{x}"
    end
  end

  # * A process can also die by explicitly sending an exit signal:
  def exit do
    try do
      exit("I am exiting")
    catch
      :exit, message -> message
    end
  end
end
