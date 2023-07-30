defmodule TwilioSip.HTTP do
  @moduledoc """
  HTTP Utils.
  """

  require Logger

  ## API

  @doc false
  @spec parse_json(String.t()) :: term
  def parse_json(json) do
    case Jason.decode(json) do
      {:ok, parsed_json} ->
        parsed_json

      {:error, reason} ->
        :ok =
          Logger.error(fn ->
            "Error parsing json. Original: #{inspect(json)}. Error: #{inspect(reason)}"
          end)

        json
    end
  end

  @doc false
  @spec normalize_headers(HTTPoison.headers()) :: HTTPoison.headers()
  def normalize_headers(headers) do
    for {name, value} <- headers do
      {String.downcase(name), value}
    end
  end
end
