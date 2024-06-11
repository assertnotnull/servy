defmodule PragRecurse do
  def my_map([], _fun), do: []

  def my_map([head | tail], fun) do
    [fun.(head) | my_map(tail, fun)]
  end
end
