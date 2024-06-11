defmodule Recurse do
  def sum([head | tail], total) do
    IO.puts("Head: #{head} Tail: #{inspect(tail, binaries: :as_binaries)}")
    sum(tail, head + total)
  end

  def sum([], total), do: total

  def triple([head | tail]) do
    [head * 3 | triple(tail)]
  end

  def triple([]), do: []

  def triple_tail([head | tail], acc) do
    triple_tail(tail, [head * 3 | acc])
  end

  def triple_tail([], acc), do: Enum.reverse(acc)
end

total = Recurse.sum([5, 10], 0)
IO.puts("Total: #{total}")

tripled = Recurse.triple([1, 2, 3])
IO.puts("Tripled: #{inspect(tripled, binaries: :as_binaries)}")

tripled_tail = Recurse.triple_tail([1, 2, 3], [])
IO.puts("Tripled Tail: #{inspect(tripled_tail, binaries: :as_binaries)}")
