defmodule Metaprograming.MathTest do
  import Metaprograming.Assertion

  def run do
    assert 5 == 15
    assert 10 > 0
    assert 1 > 2
    assert 10 * 10 == 100
  end
end
