defmodule TwilioSip.Voice.Client do
  @moduledoc """
  Handles Twilio Voice Call HTTP Routing
  """
  use HTTPoison.Base

  alias TwilioSip.HTTP

  ## HTTPoison.Base

  @account_sid Application.compile_env(:twilio_sip, :voice)[:account_sid]
  @auth_token Application.compile_env(:twilio_sip, :voice)[:auth_token]
  @base_url Application.compile_env(:twilio_sip, :voice)[:base_url]

  @doc false
  def process_request_url(url) do
    Path.join([@base_url, url])
  end

  @doc false
  def process_request_body(body) when is_map(body) do
    Jason.encode!(body)
  end

  @doc false
  def process_request_body(body), do: body

  @doc false
  def process_request_headers(headers) do
    [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Authorization",
       ("Basic " <> Base.encode64("#{@account_sid}:#{@auth_token}")) |> String.trim()}
      | headers
    ]
  end

  @doc false
  def process_request_options(options) do
    http_options = [
      timeout: 20000,
      recv_timeout: 20000,
      ssl: [{:versions, [:"tlsv1.2"]}]
    ]

    Keyword.merge(http_options, options)
  end

  @doc false
  def process_response_headers(headers) do
    HTTP.normalize_headers(headers)
  end

  @doc false
  def process_response_body(body) when is_binary(body) and byte_size(body) > 1 do
    HTTP.parse_json(body)
  end

  def process_response_body(_), do: %{}
end
