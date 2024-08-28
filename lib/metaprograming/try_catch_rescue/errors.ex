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

    # we rescued the exception, logged it, and then re-raised it.
    # We use the __STACKTRACE__ construct both when formatting the exception and when re-raising
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

  # Sometimes it's necessary to ensure that a resource is cleaned up
  #  after some action that could potentially raise an error.

  def afterfunc do
    {:ok, file} = File.open("sample", [:utf8, :write])

    try do
      IO.write(file, "olá")

      raise "oops, something went wrong"

      # The after clause will be executed regardless of whether or not the tried block succeeds
    after
      File.close(file)
    end
  end

  # will match on the results of the try block whenever the try block
  # finishes without a throw or an error.

  def elsefunc(x) do
    try do
      1 / x
    rescue
      ArithmeticError ->
        :infinity
    else
      y when y < 1 and y > -1 ->
        :small

      _ ->
        :large
    end
  end

  def returnpath do
    __DIR__
  end
end

# ? Demystifying iodata in elixir
# lists of bytes and binaries.

#  IO.iodata_to_binary([65,66])
# "AB"
#  IO.iodata_to_binary("AB")
# "AB"
#  IO.iodata_to_binary(<<65,66>>)
# "AB"
# IO.iodata_to_binary([65,66,"CD"])
# "ABCD"
#  IO.iodata_to_binary([65,66,"CD", <<69, 70, 71>>])
# "ABCDEFG"

# the main use for IOData is to avoid unnecessary memory allocation and copying.

# IO.puts ["Good morning, ", user]
