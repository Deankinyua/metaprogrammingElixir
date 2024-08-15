defmodule Metaprograming.Reduce do
  # * Reduce (sometimes called fold) as a building block of functional languages

  # * Enum.reduce(enumerable, acc, fun)

  # * Enum.reduce([1, 2, 3], 0, fn x, acc -> x + acc end)  answer => 6

  # * For example, we could implement map/2 in terms of reduce/3 as follows:

  def my_map(enumerable, fun) do
    enumerable
    |> Enum.reduce([], fn x, acc -> [fun.(x) | acc] end)
    |> Enum.reverse()

    # * assuming enumerable is [1, 2, 3] and fun is &(&1 * 2)
    # * first return is [2 | []] => [2]
    # * second return is [4 | [2]] => [4, 2]
    # * third return is [6 | [4, 2]] => [6, 4, 2]

    # * the result is then reversed with Enum.reverse/1 hence becomes => [2, 4, 6]
  end

  def map(enumerable, fun) do
    # * X basically represents an element in the enumerable
    # * the first value of X is the first element index 0 in the enumerable
    reducer = fn x, acc -> {:cont, [fun.(x) | acc]} end
    Enumerable.reduce(enumerable, {:cont, []}, reducer) |> elem(1) |> :lists.reverse()
  end

  # * first return is 1 + 0 = 1
  # * acc is now 1
  # * second return is 2 + 1 = 3
  # * acc is now 3
  # * third return is 3 + 3 = 6
  # * acc is 6 and the final answer is also 6
end
