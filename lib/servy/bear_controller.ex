defmodule Servy.BearController do
  alias Servy.Wildthings
  alias Servy.Bear
  alias Servy.View

  def index(conv) do
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)

    View.render(conv, "index.eex", bears: bears)
  end

  # defp bear_item(bear) do
  #   "<li>#{bear.name} - #{bear.type}</li>"
  # end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    View.render(conv, "show.eex", bear: bear)
  end

  def create(conv, %{"name" => name, "type" => type} = _params) do
    %{
      conv
      | status: 201,
        resp_body: "Created a #{type} bear named #{name}!"
    }
  end

  def delete(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    %{conv | status: 200, resp_body: "Deleted bear #{bear.id} - #{bear.name}"}
  end
end
