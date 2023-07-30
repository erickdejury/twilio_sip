defmodule TwilioSipWeb.VoiceController do
  use TwilioSipWeb, :controller

  @spec process_input(Plug.Conn.t(), Plug.Conn.t())
  def process_input(conn, %{"Digits" => digits}) do
    xml_response =
      case digits do
        "1" ->
          """
          <?xml version="1.0" encoding="UTF-8"?>
          <Response>
            <Say>Why don't scientists trust atoms? Because they make up everything!</Say>
          </Response>
          """

        "2" ->
          """
          <?xml version="1.0" encoding="UTF-8"?>
          <Response>
            <Say>Connecting you to Erick. Please wait.</Say>
            <Dial>+254792417156</Dial>
          </Response>
          """

        _ ->
          """
          <?xml version="1.0" encoding="UTF-8"?>
          <Response>
            <Say>You entered an invalid option. Goodbye!</Say>
          </Response>
          """
      end

    conn
    |> put_resp_content_type("text/xml")
    |> send_resp(200, xml_response)
  end

  def process_input(conn, _params) do
    # If no "Digits" parameter is present, respond with a goodbye message
    xml_response = """
    <?xml version="1.0" encoding="UTF-8"?>
    <Response>
      <Say>We didn't receive any input. Goodbye!</Say>
    </Response>
    """

    conn
    |> put_resp_content_type("text/xml")
    |> send_resp(200, xml_response)
  end
end
