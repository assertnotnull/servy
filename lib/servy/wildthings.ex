defmodule Servy.Wildthings do
  alias Servy.Bear

  def list_bears do
    Path.expand("../../db", __DIR__)
    |> Path.join("bears.json")
    |> read_json
    |> Poison.decode!(as: %{"bears" => [%Bear{}]})
    |> Map.get("bears")
  end

  defp read_json(source) do
    case File.read(source) do
      {:ok, contents} ->
        contents

      {:error, reason} ->
        IO.inspect("Error reading #{source}: #{reason}")
        "[]"
    end
  end

  def get_bear(id) when is_integer(id) do
    Enum.find(list_bears(), fn b -> b.id == id end)
  end

  def get_bear(id) when is_binary(id) do
    IO.inspect(id)
    id |> String.to_integer() |> get_bear()
  end
end
