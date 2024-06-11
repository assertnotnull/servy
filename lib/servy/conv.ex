defmodule Servy.Conv do
  defstruct method: "",
            path: "",
            resp_headers: %{"Content-Type" => "text/html"},
            resp_body: "",
            status: nil,
            params: %{},
            headers: %{}

  def full_status(conv) do
    "#{conv.status} #{status_reason(conv.status)}"
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end

  def put_resp_content_type(conv, value) do
    headers = Map.put(conv.resp_headers, "Content-Type", value)
    %{conv | resp_headers: headers}
  end
end
