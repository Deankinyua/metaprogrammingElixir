defmodule Metaprograming.IfRecreated do
  # * Extend Elixir with MetaProgramming chapter 2 of Elixir in Action
  defmacro my_if(expr, do: if_block) do
    quote do
      if(unquote(expr), do: unquote(if_block), else: unquote(nil))
    end
  end

  defmacro my_if(expr, do: if_block, else: else_block) do
    quote do
      case unquote(expr) do
        result when result in [false, nil] -> unquote(else_block)
        _ -> unquote(if_block)
      end
    end
  end

  def iffer(name) do
    if name == "dean" do
      true
    else
      false
    end
  end

  # IfRecreated.my_if 10 == 1 do
  #   "correct"
  # else
  #   "incorrect"
  # end

  # note: Pattern matching is key

  # IfRecreated.my_if 5 == 5, do: "correct", else: "incorrect"
  # IfRecreated.my_if 6 == 5, do: "correct"
  # IfRecreated.my_if 5 == 5, do: "correct", else: "incorrect"
end
