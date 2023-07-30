defmodule TwilioSip.Voice.Adapter do
  @moduledoc """

  """
  alias TwilioSip.Voice.Client
  @phone_number Application.compile_env(:twilio_sip, :voice)[:phone_number]
  @call_url Application.compile_env(:twilio_sip, :voice)[:call_url]

  def make_call(to_phone_number) do
    params = [{"Url", @call_url}, {"To", to_phone_number}, {"From", @phone_number}]

    case Client.post("", URI.encode_query(params)) do
      {:ok, %HTTPoison.Response{status_code: 201, body: body}} ->
        IO.puts("Request successful.")
        IO.inspect(body)

      {:ok, %HTTPoison.Response{status_code: status, body: body}} ->
        IO.puts("Request failed with status: #{status}")
        IO.inspect(body)

      {:error, reason} ->
        IO.puts("Failed to make the request: #{inspect(reason)}")
    end
  end
end
