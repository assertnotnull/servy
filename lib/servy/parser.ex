defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\r\n\r\n")

    [request_line | header_lines] = String.split(top, "\r\n")

    headers = parse_headers(header_lines, %{})

    [method, path, _] = String.split(request_line, " ")

    params = parse_params(headers["Content-Type"], params_string)

    %Conv{method: method, path: path, params: params, headers: headers}
  end

  def parse_headers([head | tail], headers) do
    [key, value] = String.split(head, ": ")
    headers = Map.put(headers, key, value)
    parse_headers(tail, headers)
  end

  # def parse_headers(lines, headers) do
  #   Enum.reduce(lines, headers, fn line, acc ->
  #     [key, value] = String.split(line, ": ")
  #     Map.put(acc, key, value)
  #   end)
  # end

  def parse_headers([], headers), do: headers

  @doc """
  Parses a string of URL-encoded parameters into a map.

  ## Examples

      iex> Servy.Parser.parse_params("application/x-www-form-urlencoded", "a=1&b=2")
      %{"a" => "1", "b" => "2"}
  """
  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string
    |> String.trim()
    |> URI.decode_query()
  end

  def parse_params("application/json", params_string) do
    Poison.Parser.parse!(params_string)
  end

  def parse_params(_, _), do: %{}
end
